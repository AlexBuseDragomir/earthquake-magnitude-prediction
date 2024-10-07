# Earthquake magnitude prediction using ML

Machine learning project written in R.  
Predicting the magnitude of an earthquake based on historical data.

The source for my dataset is represented by the website [www.kaggle.com](https://www.kaggle.com), one of the most used platforms of this kind, together with Google Datasets, data.world, and the UCI Machine Learning Repository.

I chose to use the dataset named **“Significant earthquakes, 1965-2016”**. As the name implies, it is a large dataset that contains relevant information about significant earthquakes (with a magnitude over 5.5 on the Richter scale) and their intrinsic and extrinsic properties. The dataset includes 21 columns of data and over 20,000 records, though some rows have missing values.

The source for the dataset is The National Earthquake Information Center (NEIC), which determines the location and size of all significant earthquakes worldwide and disseminates this information immediately to national and international agencies, scientists, critical facilities, and the general public. The NEIC compiles and provides to scientists and the public an extensive seismic database, serving as a foundation for scientific research. This is accomplished through the operation of modern digital national and global seismograph networks and cooperative international agreements. The NEIC also serves as the national data center and archive for earthquake information.

To conclude, this dataset includes records of the date, time, location, depth, magnitude, and source of every earthquake with a reported magnitude of 5.5 or higher since 1965.

As some data fields had no clear relationship with the magnitude, the fields retained for the final project are as follows:

- **Latitude**: Geographic coordinate that specifies the north-south position of the earthquake's epicenter.
- **Longitude**: Geographic coordinate that specifies the east-west position of the earthquake's epicenter.
- **Depth**: The depth (measured in meters) at which the earthquake's epicenter was located.
- **Azimuthal gap**: The azimuth is an angular measurement in a spherical coordinate system. It is the angle between a reference vector on a plane and the projected vector from an observer to a point of interest.
- **Horizontal distance**: The distance in degrees from the epicenter to the nearest station. (1 degree ≈ 111.2 kilometers). Generally, the smaller this number, the more reliable the depth calculation.
- **Root mean square (RMS)**: A post-stack attribute that computes the square root of the sum of squared amplitudes divided by the number of samples within the specified window. It measures reflectivity to map hydrocarbon indicators but is sensitive to noise.
- **Magnitude**: A post-stack attribute that computes the maximum value of the absolute amplitudes within a window. It can map the strongest hydrocarbon indicators within a zone of interest.
