# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

embassies = Embassy.create([
  { name: 'Syldavia'},
  { name: 'Borduria'}
])

consuls = Consul.create([
  { name: 'Hergé', embassy: Embassy.first, email: 'herge@example.com', password: 'foobar', minister: true },
  { name: 'Muskar III', embassy: Embassy.first, email: 'muskar@example.com', password: 'foobar' },
  { name: 'Mustler', embassy: Embassy.last, email: 'mustler@example.com', password: 'foobar' }
], without_protection: true)

ambassadors = Ambassador.create([
  { name: 'Tintín', email: 'tintin@example.com', password: 'foobar', tracking_id: '987b1732ac' },
  { name: 'Haddock', email: 'haddock@example.com', password: 'foobar' },
  { name: 'Sponsz', email: 'sponsz@example.com', password: 'foobar' },
  { name: 'Tapioca', email: 'tapioca@example.com', password: 'foobar' }
], without_protection: true)

Embassy.first.ambassadors << Ambassador.first
Embassy.first.ambassadors << Ambassador.all[1]
Embassy.last.ambassadors << Ambassador.all[2]
Embassy.last.ambassadors << Ambassador.last

missions = Mission.create([
  { name: 'El Cetro de Ottokar', embassy: Embassy.first, short_description: 'Get the Sceptre back!', tracking_url: 'www.sinapse.es/sandbox/pixel/destination_p.html', tracking_id: 'e0944ff734' },
  { name: 'Objetivo: la Luna', embassy: Embassy.first, short_description: 'Arrive at the Moon!', tracking_url: 'es.wikipedia.org/wiki/Objetivo:_la_Luna' },
  { name: 'El asunto Tornasol', embassy: Embassy.last, short_description: 'Kidnap Tornasol!', tracking_url: 'es.wikipedia.org/wiki/El_asunto_Tornasol' },
  { name: 'Tintín y los Pícaros', embassy: Embassy.last, short_description: 'Depose Alcázar!', tracking_url: 'es.wikipedia.org/wiki/Tintín_y_los_Pícaros' }
], without_protection: true)

rewards = Reward.create([
  { name: 'Salvador de Ottokar', mission: Mission.first, target_points: 2 },
  { name: 'Caballero del Pelícano Negro', mission: Mission.first, target_points: 4 },
  { name: 'Astronauta Titulado', mission: Mission.all[1], target_points: 6 },
  { name: 'Selenita', mission: Mission.all[1], target_points: 8 },
  { name: 'Espía Descarado', mission: Mission.all[2], target_points: 5 },
  { name: '007', mission: Mission.all[2], target_points: 10 },
  { name: 'Revolucionario Bananero', mission: Mission.last, target_points: 15 },
  { name: 'Portador del Mostacho de Plekszy-Gladz', mission: Mission.last, target_points: 20 }
], without_protection: true)

search_terms = SearchTerm.create([
  { term: "Term 1"},
  { term: "Term 2"},
  { term: "Term 3"}  
], without_protection: true)

slogans = Slogan.create([
  { mission_id: Mission.first.id, search_term_id: SearchTerm.first.id},
  { mission_id: Mission.first.id, search_term_id: SearchTerm.all[1].id },
  { mission_id: Mission.last.id, search_term_id: SearchTerm.last.id }
], without_protection: true)

  # points = Point.create([
  #   { ambassador_id: 1, mission_id: 1 },
  #   { ambassador_id: 1, mission_id: 1 },
  #   { ambassador_id: 1, mission_id: 1 },
  #   { ambassador_id: 1, mission_id: 1 },
  #   { ambassador_id: 1, mission_id: 2 },
  #   { ambassador_id: 1, mission_id: 2 },
  #   { ambassador_id: 2, mission_id: 1 },
  #   { ambassador_id: 2, mission_id: 1 },
  #   { ambassador_id: 2, mission_id: 2 },
  #   { ambassador_id: 2, mission_id: 2 },
  #   { ambassador_id: 2, mission_id: 2 },
  #   { ambassador_id: 2, mission_id: 2 },
  #   { ambassador_id: 2, mission_id: 2 },
  #   { ambassador_id: 2, mission_id: 2 },
  #   { ambassador_id: 3, mission_id: 3 },
  #   { ambassador_id: 3, mission_id: 3 },
  #   { ambassador_id: 3, mission_id: 4 },
  #   { ambassador_id: 3, mission_id: 4 },
  #   { ambassador_id: 3, mission_id: 4 },
  #   { ambassador_id: 3, mission_id: 4 },
  #   { ambassador_id: 4, mission_id: 3 },
  #   { ambassador_id: 4, mission_id: 3 },
  #   { ambassador_id: 4, mission_id: 3 },
  #   { ambassador_id: 4, mission_id: 3 },
  #   { ambassador_id: 4, mission_id: 3 },
  #   { ambassador_id: 4, mission_id: 3 },
  #   { ambassador_id: 4, mission_id: 4 },
  #   { ambassador_id: 4, mission_id: 4 }
  # ], without_protection: true)