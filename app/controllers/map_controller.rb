class MapController < ApplicationController
	include MapHelper

	def index
	end

	def ten_trips
		# hash = Gmaps4rails.build_markers(next_ten_trips) do |trip, marker|
		# 	station = Station.find_by(station_id: trip.origin_station_id)
		#   marker.lat(station.latitude)
		#   marker.lng(station.longitude)
		#   marker.json({
		#   	trip_id: trip.trip_id,
		#   	# start_time: DateTime.parse(trip.start_time).strftime("%I:%M%p on %m/%d/%Y"),
		#   	# stop_time: DateTime.parse(trip.stop_time).strftime("%I:%M%p on %m/%d/%Y"),
		#   	start_time: trip.start_time,
		#   	stop_time: trip.stop_time,
		#   	duration: trip.trip_duration
		#   })
		# end
		array = Trip.where(bike_id: params[:bike_id].to_i).offset(0).limit(10).order(:start_time).to_a
		render json: array
	end

	def get_next_trip
		hash = Gmaps4rails.build_markers(next_trip) do |trip, marker|
			station = Station.find_by(station_id: trip.origin_station_id)
		  marker.lat(station.latitude)
		  marker.lng(station.longitude)
		  marker.json({
		  	start_time: DateTime.parse(trip.start_time).strftime("%I:%M%p on %m/%d/%Y"),
		  	stop_time: DateTime.parse(trip.stop_time).strftime("%I:%M%p on %m/%d/%Y"),
		  	duration: trip.trip_duration
		  })
		end
		render json: hash
	end
end
