library(HistMapR)

ras.halley_2002 <- stack("maps/halley_2002.tiff")
names(ras.halley_2002)
ras.halley_2002 <- dropLayer(ras.halley_2002, 4)
names(ras.halley_2002)<-c("red","green","blue")
plotRGB(ras.halley_2002, 1, 2, 3)
smoothed.halley_2002 <- smooth_map(ras.halley_2002, window.size = 3, smooth.function = min, dark.rm = TRUE, darkValue = 110)
plotRGB(smoothed.halley_2002, 1, 2, 3)
halley_vals <- click_sample(ras.halley_2002, cats = c("Eurasian", "American", "Refugia"), npoints=10)

# View the table showing the values of the clicked pixels
halley_vals$sample.table

# Just the colour summary
halley_vals$colour.summary

halley_col_table <- halley_vals$colour.summary

# Due to the computation time required, it can be useful to use the aggregate function to speed up the testing.
ras.smoothed.agg<-aggregate(ras.halley_2002,fact=10,fun=mean)

# First test by plotting, not saving the (aggregated) raster. Suitable settings will depend on where was clicked above.
test<-class_map(ras.smoothed.agg, colour.table=halley_col_table, errors=2, plot.raster = TRUE, raster.summary=FALSE, save.raster = FALSE)
