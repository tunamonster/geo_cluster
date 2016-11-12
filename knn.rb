require 'geocoder'

def cluster(locations, clusters)

	def distance_between(p1,p2)
		Geocoder::Calculations.distance_between(p1, p2)
	end

	def geographic_center(array)
		Geocoder::Calculations.geographic_center(array)
	end

	def initialize_cluster_tree(c, points)
		raise "Can not have more clusters than locations." if c > points.count
		locs = points.clone
		cluster_tree = Hash.new
		until cluster_tree.count == c
			centroid = locs[rand(locs.count)]		 
			locs.delete centroid
			cluster_tree.merge!(cluster_tree.count => {centroid: centroid, points: []})
		end
		cluster_tree
	end

	def assign_nearest(locations, cluster_tree)
		centroids = cluster_tree.map {|k,v| v[:centroid]}
			locations.each do |point|
				nearest_cluster = centroids.map { |c| distance_between(point, c) }.each_with_index.min[1]
				cluster_tree[nearest_cluster][:points] << point 
			end
	end

	def adjust_centroids(cluster_tree)
		converged_clusters = 0	
			cluster_tree.each do |cluster, values|
				centroid = values[:centroid]
				values[:centroid] = geographic_center(values[:points])
				cluster_tree.delete(cluster) if values[:centroid][0].nan?
				converged_clusters += 1 if centroid == values[:centroid]
			end
			[cluster_tree, (converged_clusters == cluster_tree.count)]
	end

	def sanitize(cluster_tree)
		cluster_tree.each {|cluster, values| values[:points] = [] }
	end

	def score(cluster_tree)
		distance_score = 0
		cluster_tree.each do |cluster, values|
			values[:points].each { |point| distance_score += distance_between(point, values[:centroid]) }
		end
		[distance_score, cluster_tree]
	end

	def iterate(cluster_tree, locations)
		iterations_limit = 10
			iterations_limit.times do
				sanitize(cluster_tree)
				assign_nearest(locations, cluster_tree)
				cluster_tree, converged = adjust_centroids(cluster_tree)
				break if converged == true
			end
		score(cluster_tree)	
	end

	overall_score = []
	generations = 100
	generations.times do |i|
		cluster_tree = initialize_cluster_tree(clusters, locations)
		overall_score << iterate(cluster_tree, locations)
	end

	overall_score.min_by(&:first)
end

