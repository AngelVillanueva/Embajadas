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
  { name: 'Hergé', embassy_id: 1, email: 'herge@example.com', password: 'foobar', minister: true },
  { name: 'Muskar III', embassy_id: 1, email: 'muskar@example.com', password: 'foobar' },
  { name: 'Mustler', embassy_id: 2, email: 'mustler@example.com', password: 'foobar' }
], without_protection: true)

ambassadors = Ambassador.create([
  { name: 'Tintín', embassy_id: 1, email: 'tintin@example.com', password: 'foobar', tracking_id: '987b1732ac' },
  { name: 'Haddock', embassy_id: 1, email: 'haddock@example.com', password: 'foobar' },
  { name: 'Sponsz', embassy_id: 2, email: 'sponsz@example.com', password: 'foobar' },
  { name: 'Tapioca', embassy_id: 2, email: 'tapioca@example.com', password: 'foobar' }
], without_protection: true)

missions = Mission.create([
  { name: 'El Cetro de Ottokar', embassy_id: 1, short_description: 'Get the Sceptre back!', tracking_url: 'www.sinapse.es/sandbox/pixel/destination_p.html', tracking_id: 'e0944ff734' },
  { name: 'Objetivo: la Luna', embassy_id: 1, short_description: 'Arrive at the Moon!', tracking_url: 'es.wikipedia.org/wiki/Objetivo:_la_Luna' },
  { name: 'El asunto Tornasol', embassy_id: 2, short_description: 'Kidnap Tornasol!', tracking_url: 'es.wikipedia.org/wiki/El_asunto_Tornasol' },
  { name: 'Tintín y los Pícaros', embassy_id: 2, short_description: 'Depose Alcázar!', tracking_url: 'es.wikipedia.org/wiki/Tintín_y_los_Pícaros' }
], without_protection: true)

rewards = Reward.create([
  { name: 'Salvador de Ottokar', mission_id: 1, target_points: 2 },
  { name: 'Caballero del Pelícano Negro', mission_id: 1, target_points: 4 },
  { name: 'Astronauta Titulado', mission_id: 2, target_points: 6 },
  { name: 'Selenita', mission_id: 2, target_points: 8 },
  { name: 'Espía Descarado', mission_id: 3, target_points: 5 },
  { name: '007', mission_id: 3, target_points: 10 },
  { name: 'Revolucionario Bananero', mission_id: 4, target_points: 15 },
  { name: 'Portador del Mostacho de Plekszy-Gladz', mission_id: 4, target_points: 20 }
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