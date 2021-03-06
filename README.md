# geo_cluster
This is an unsupervised clustering algorithm to group geospatial data, based on a euclidean KNN approach. It randomly resamples starting points and returns the configuration with the lowest distance score.

# Benchmarks best and worst distance scores: 
# uniformly sampled points in n x n space 
![alt tag](https://raw.githubusercontent.com/tunamonster/geo_cluster/master/img/best-200.png)
![alt tag](https://raw.githubusercontent.com/tunamonster/geo_cluster/master/img/worst-200.png)


# an x n space (note the x-axis)
![alt tag](https://raw.githubusercontent.com/tunamonster/geo_cluster/master/img/rect-best-200.png)
![alt tag](https://raw.githubusercontent.com/tunamonster/geo_cluster/master/img/rect-worst-200.png)


# Concentric cricles
![alt tag](https://raw.githubusercontent.com/tunamonster/geo_cluster/master/img/circ-best-120.png)
![alt tag](https://raw.githubusercontent.com/tunamonster/geo_cluster/master/img/circ-worst-120.png)

