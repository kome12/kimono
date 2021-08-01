library(ggplot2)

aggregatedData <- read.csv("/Users/ko/GitHub/kimono/raw_data/student_response_aggregated.csv", header=TRUE)

# plot(x = aggregatedData$Nihon, y = aggregatedData$Basic)
aggregatedPlot <- ggplot(aggregatedData, aes(x = Nihon, y = Basic)) +
  geom_point(aes(color = factor(Type))) +
  geom_point(alpha = 1/50) +
  scale_color_gradientn(colors = rainbow(5))

# print(aggregatedPlot)

aggregatedPlotSplit <- ggplot(aggregatedData, aes(x = Basic, y = Nihon, color = factor(Type))) +
  # geom_point(aes(color = factor(Type))) +
  geom_point(alpha = 1/4) +
  facet_wrap("Type") +
    labs(title=" ", x=" ", y=" ", color="")
  # scale_color_gradientn(colors = rainbow(factor(aggregatedData$Type)))

print(aggregatedPlotSplit)


sumByType <- read.csv("/Users/ko/GitHub/kimono/raw_data/student_response_sum_by_type.csv", header=TRUE)

# sumByTypePlot <- ggplot(sumByType, aes(x = Nihon, y = Basic)) + geom_point(aes(color = factor(Type)))

# print(sumByTypePlot)