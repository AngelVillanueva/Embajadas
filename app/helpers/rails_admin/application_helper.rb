require 'rails_admin/i18n_support'

module RailsAdmin
  module ApplicationHelper

    include RailsAdmin::I18nSupport

    def authorized?(action, abstract_model = nil, object = nil)
      object = nil if object.try :new_record?
      @authorization_adapter.nil? || @authorization_adapter.authorized?(action, abstract_model, object)
    end

    def current_action?(action, abstract_model = @abstract_model, object = @object)
      @action.custom_key == action.custom_key &&
      abstract_model.try(:to_param) == @abstract_model.try(:to_param) &&
      (@object.try(:persisted?) ? @object.id == object.try(:id) : !object.try(:persisted?))
    end

    def action(key, abstract_model = nil, object = nil)
      RailsAdmin::Config::Actions.find(key, { :controller => self.controller, :abstract_model => abstract_model, :object => object })
    end

    def actions(scope = :all, abstract_model = nil, object = nil)
      RailsAdmin::Config::Actions.all(scope, { :controller => self.controller, :abstract_model => abstract_model, :object => object })
    end

    def edit_user_link
      return nil unless authorized?(:edit, _current_user.class, _current_user) && _current_user.respond_to?(:email)
      return nil unless abstract_model = RailsAdmin.config(_current_user.class).abstract_model
      return nil unless edit_action = RailsAdmin::Config::Actions.find(:edit, {:controller => self.controller, :abstract_model => abstract_model, :object => _current_user })
      link_to _current_user.email, url_for(:action => edit_action.action_name, :model_name => abstract_model.to_param, :id => _current_user.id, :controller => 'rails_admin/main')
    end

    def logout_path
      if defined?(Devise)
        scope = Devise::Mapping.find_scope!(_current_user)
        main_app.send("destroy_#{scope}_session_path") rescue false
      end
    end

    def wording_for(label, action = @action, abstract_model = @abstract_model, object = @object)
      model_config = abstract_model.try(:config)
      object = abstract_model && object.is_a?(abstract_model.model) ? object : nil
      action = RailsAdmin::Config::Actions.find(action.to_sym) if (action.is_a?(Symbol) || action.is_a?(String))

      I18n.t("admin.actions.#{action.i18n_key}.#{label}",
        :model_label => model_config.try(:label),
        :model_label_plural => model_config.try(:label_plural),
        :object_label => model_config && object.try(model_config.object_label_method)
      )
    end

    #overrided to include Dashboard home link
    def main_navigation
      nodes_stack = RailsAdmin::Config.visible_models(:controller => self.controller)
      node_model_names = nodes_stack.map{ |c| c.abstract_model.model_name }

      nodes_stack.group_by(&:navigation_label).map do |navigation_label, nodes|

        nodes = nodes.select{ |n| n.parent.nil? || !n.parent.to_s.in?(node_model_names) }
        li_stack = navigation nodes_stack, nodes

        li_a_home = link_to localizing_path(dashboard_path), class: 'pjax' do
          content_tag(:i, '', class: 'icon icon-home') + content_tag(:span, t('admin.actions.dashboard.menu'))
        end
        %{<li class="homelink">#{li_a_home}</li>#{li_stack}} if li_stack.present?
      end.join.html_safe
    end

    def static_navigation
      li_stack = RailsAdmin::Config.navigation_static_links.map do |title, url|
        content_tag(:li, link_to(title.to_s, url, :target => '_blank'))
      end.join

      label = RailsAdmin::Config.navigation_static_label || t('admin.misc.navigation_static_label')
      li_stack = %{<li class='nav-header'>#{label}</li>#{li_stack}}.html_safe if li_stack.present?
      li_stack
    end

    #overrided to call locale_url_for
    def navigation nodes_stack, nodes, level=0
      nodes.map do |node|
        model_param = node.abstract_model.to_param
        url         = locale_url_for(:action => :index, :controller => 'rails_admin/main', :model_name => model_param)
        level_class = " nav-level-#{level}" if level > 0

        li = content_tag :li, "data-model"=>model_param do
          #content_tag(:i, '', class: "icon icon-#{model_param}")
          #link_to(node.label_plural, url, :class => "pjax#{level_class}")
          adata = t('admin.menu.tip.'"#{model_param}")
          link_to url, class: "tip-right pjax#{level_class}", 'data-original-title' => adata do
            content_tag(:i, '', class: "icon icon-#{model_param}") + content_tag(:span, node.label_plural )
          end
        end
        li + navigation(nodes_stack, nodes_stack.select{ |n| n.parent.to_s == node.abstract_model.model_name}, level+1)
      end.join.html_safe
    end

    #overrided to call locale_url_for
    def breadcrumb action = @action, acc = []
      begin
        (parent_actions ||= []) << action
      end while action.breadcrumb_parent && (action = action(*action.breadcrumb_parent))

      content_tag(:ul, :class => "breadcrumb", :id => "breadcrumb") do
        parent_actions.map do |a|
          am = a.send(:eval, 'bindings[:abstract_model]')
          o = a.send(:eval, 'bindings[:object]')
          content_tag(:li, :class => current_action?(a, am, o) && "active") do
            crumb = if a.http_methods.include?(:get)
            current_action?(a, am, o) ? aclass = 'pjax tip-bottom current' : aclass = 'pjax tip-bottom'
            if a.action_name == :dashboard
              adata = t('admin.menu.Gohome')
            else
              adata = t('admin.menu.Gosection')
            end
              link_to locale_url_for(:action => a.action_name, :controller => 'rails_admin/main', :model_name => am.try(:to_param), :id => (o.try(:persisted?) && o.try(:id) || nil)), "data-original-title" => adata, :class => aclass do
                if a.action_name == :dashboard
                  icon = content_tag(:i, '', :class => 'icon-home')
                else
                  icon = ''
                end
                icon + wording_for(:breadcrumb, a, am, o)
              end
            else
              content_tag(:span, wording_for(:breadcrumb, a, am, o))
            end
            #crumb+= content_tag(:span, '/', :class => 'divider') unless current_action?(a, am, o)
            crumb+= content_tag(:span, '') unless current_action?(a, am, o)
            crumb
          end
        end.reverse.join().html_safe
      end
    end

    # parent => :root, :collection, :member
    #overrided to call locale_url_for
    def menu_for(parent, abstract_model = nil, object = nil, only_icon = false) # perf matters here (no action view trickery)
      actions = actions(parent, abstract_model, object).select{ |a| a.http_methods.include?(:get) }
      actions.map do |action|
        wording = wording_for(:menu, action)
        %{
          <li title="#{wording if only_icon}" rel="#{'tooltip' if only_icon}" class="icon #{action.key}_#{parent}_link #{'active' if current_action?(action)}">
            <a class="pjax" href="#{locale_url_for({ :action => action.action_name, :controller => 'rails_admin/main', :model_name => abstract_model.try(:to_param), :id => (object.try(:persisted?) && object.try(:id) || nil) })}">
              <i class="#{action.link_icon}"></i>
              <span#{only_icon ? " style='display:none'" : ""}>#{wording}</span>
            </a>
          </li>
        }
      end.join.html_safe
    end

    def bulk_menu abstract_model = @abstract_model
      actions = actions(:bulkable, abstract_model)
      return '' if actions.empty?
      content_tag :li, { :class => 'dropdown', :style => 'float:right' } do
        content_tag(:a, { :class => 'dropdown-toggle', :'data-toggle' => "dropdown", :href => '#' }) { t('admin.misc.bulk_menu_title').html_safe + '<b class="caret"></b>'.html_safe } +
        content_tag(:ul, :class => 'dropdown-menu', :style => 'left:auto; right:0;') do
          actions.map do |action|
            content_tag :li do
              link_to wording_for(:bulk_link, action), '#', :onclick => "jQuery('#bulk_action').val('#{action.action_name}'); jQuery('#bulk_form').submit(); return false;"
            end
          end.join.html_safe
        end
      end.html_safe
    end

    ## NEW CUSTOM HELPERS
    # main chart html
    def main_chart total_days, models
      content_tag :div, { id: 'chart_data', style: 'display:none;', 'data-custom-fdate' => total_days } do
        models.each_with_index.map do |model, i|
          filters = relevant_filters model
          content_tag :div, { id: "serie_#{i+1}", "data-custom-label" => I18n.t("activerecord.models.#{model.to_s.underscore.downcase}.other")} do
            (2..total_days).to_a.collect do |day|
              concat content_tag(:span, daily_count(model, total_days-day, filters), class: day, style: 'display:none;', "data-custom-date" => (total_days-day).days.ago.to_i*1000)
            end
          end
        end.join.html_safe
      end.html_safe
    end

    # custom for the charts
    def active_ambassadors
      ( current_consul.minister? && Ambassador.count ) || current_consul.embassy.ambassadors.count
    end
    def current_points
      ( current_consul.minister? && Point.count ) || Point.where(mission_id: current_consul.embassy.mission_ids).count
    end
    def current_posts
      slogan_ids = Slogan.where(mission_id: current_consul.embassy.mission_ids)
      ( current_consul.minister? && Post.count ) || Post.where(slogan_id: slogan_ids).count
    end
    def current_badges
      reward_ids = Reward.where(mission_id: current_consul.embassy.mission_ids)
      ( current_consul.minister? && Badge.count ) || Badge.where(reward_id: reward_ids).count
    end
    
    def relevant_filters model
      relevant = {}
      case model.to_s
      when "Ambassador"
        related = "id"
        ids = current_consul.embassy.ambassador_ids
      when "Point"
        related = "mission_id"
        ids = current_consul.embassy.mission_ids
      when "Post"
        slogan_ids = Slogan.where(mission_id: current_consul.embassy.mission_ids)
        related = "slogan_id"
        ids = slogan_ids
      when "Badge"
        reward_ids = Reward.where(mission_id: current_consul.embassy.mission_ids)
        related = "reward_id"
        ids = reward_ids
      end
      relevant["field"] = related
      relevant["ids"] = ids
      relevant
    end

    def daily_count model, days_ago, filters
      the_date = Date.today - days_ago
      if current_consul.minister?
        count = model.where("DATE(created_at) = ?", the_date).count
      else
      query_hash = {}
      relevant = filters
      field = relevant["field"]
      query_hash[:date] = the_date
      query_hash[:ids] = relevant["ids"]
      count = model.where("DATE(created_at) = :date and #{field} in (:ids)", query_hash).count
      end
    end

    
    # helpers for the peity charts
    def range_for_graph model, interval, type
      graph_range = []
      interval.times do |time_ago|
        case current_consul.minister?
        when true
          if type == "days"
            count = model.where("DATE(created_at) = ?", time_ago.days.ago).count
          else
            count = model.where(created_at: (time_ago+1).weeks.ago..(time_ago).weeks.ago).count
          end
        else
          if type == "days"
            case model.to_s
            when "Ambassador"
              count = model.where("DATE(created_at) = :date and id in (:ids)", date: time_ago.days.ago, ids: current_consul.embassy.ambassador_ids).count
            when "Point"
              count = model.where("DATE(created_at) = :date and mission_id in (:ids)", date: time_ago.days.ago, ids: current_consul.embassy.mission_ids).count
            when "Post"
              slogan_ids = Slogan.where(mission_id: current_consul.embassy.mission_ids)
              count = model.where("DATE(created_at) = :date and slogan_id in (:ids)", date: time_ago.days.ago, ids: slogan_ids).count
            when "Badge"
              reward_ids = Reward.where(mission_id: current_consul.embassy.mission_ids)
              count = model.where("DATE(created_at) = :date and reward_id in (:ids)", date: time_ago.days.ago, ids: reward_ids).count
            else
              count = model.where("DATE(created_at) = ?", time_ago.days.ago).count
            end
          else
            case model.to_s
            when "Ambassador"
              count = model.where(created_at: (time_ago+1).weeks.ago..(time_ago).weeks.ago, id: current_consul.embassy.ambassador_ids).count
            when "Point"
              count = model.where(created_at: (time_ago+1).weeks.ago..(time_ago).weeks.ago, mission_id: current_consul.embassy.mission_ids).count
            when "Post"
              slogan_ids = Slogan.where(mission_id: current_consul.embassy.mission_ids)
              count = model.where(created_at: (time_ago+1).weeks.ago..(time_ago).weeks.ago, slogan_id: slogan_ids).count
            when "Badge"
              reward_ids = Reward.where(mission_id: current_consul.embassy.mission_ids)
              count = model.where(created_at: (time_ago+1).weeks.ago..(time_ago).weeks.ago, reward_id: reward_ids).count
            else
              count = model.where(created_at: (time_ago+1).weeks.ago..(time_ago).weeks.ago).count
            end
          end
        end
        graph_range << count
      end
      graph_range.reverse.join(",")
    end

    def growth_perc model, day_range, type
      return "N/A" unless model.count > 0
      pair = range_for_graph(model, day_range, type).split(",")
      case pair.last
        when nil? || pair[0]
          "= 0%"
        when "0"
          if pair[0].to_f > 0
            "-100%"
          else
            "= 0%"
          end
        else
          if pair[0] == "0"
            growth = 100
          else
            growth = ((pair.last.to_f / pair[0].to_f - 1) * 100).round(0)
          end
          sign = (growth < 0 && "") || "+"
          result = (growth == 100 && "+100%") || sign + growth.to_s + "%"
        end
    end
    # end of helpers for the peity charts
  end
end

