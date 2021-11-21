library(ggplot2)

# data <- read.csv("/Users/ko/GitHub/kimono/raw_data/kimono_aggregated_data.csv", header=TRUE)
# data <- read.csv("/Users/ko/GitHub/kimono/raw_data/kimono_raw_data_a.csv", header=TRUE)
# data <- read.csv("/Users/ko/GitHub/kimono/raw_data/kimono_aggregated_data.csv", header=TRUE)
nihonData <- read.csv("/Users/ko/GitHub/kimono/raw_data/kimono_nihon_data.csv", header=TRUE)
basicData <- read.csv("/Users/ko/GitHub/kimono/raw_data/kimono_basic_data.csv", header=TRUE)

# head(data)
# summary(data)

# print(head(data))

# plot(data$Rank, data$Votes, pch = data$Type, col = as.factor(data$Type))

# violin <- ggplot(data, aes(x = CategoryType, y = Rank, fill = Type)) + geom_violin() + stat_summary(fun.y = "median", geom = "point", shape = 2, size = 3, color = "red")

# print(violin)


nihonViolin <- ggplot(nihonData, aes(x = Type, y = Rank, color = Type)) +
  geom_violin() + 
  stat_summary(fun = "mean", geom = "point", size = 1, color = "red") +
  labs(x=" ", y=" ", color=" ") + theme_bw()
  # theme(text = element_text(family = "HiraKakuProN-W3"))

basicViolin <- ggplot(basicData, aes(x = Type, y = Rank, color = Type)) +
  geom_violin() +
  stat_summary(fun = "mean", geom = "point", size = 1, color = "red") +
  labs(title=" ", x=" ", y=" ", color="")  + theme_bw()

# print(nihonViolin)
# print(basicViolin)

# test <- ggplot(data, aes(x = Rank, y = Votes)) + geom_violin()
# print(test)



library(plotrix)

# test <- violin_plot(data)
# test


 # plotting a data frame
#  violin_plot(mtcars)

#  set.seed(42)
#  normvar<-c(rnorm(49),-3)
#  unifvar<-runif(50,-2,2)
#  normvar2<-rnorm(45)

#  # plotting a matrix
#  violin_plot(matrix(c(normvar,unifvar),ncol=2),
#   main="Default Plot",x_axis_labels=c("Normal","Uniform"))

#  plotting with different colors and with at specified
#  violin_plot(matrix(c(normvar,unifvar),ncol=2),at=1:3,
#   main="Different colors and extra space",
#   x_axis_labels=c("Normal","Uniform","Normal"),
#   show_outliers=TRUE,col=c("blue","red"),median_col="lightgray",
#   pch=6)

 # adding a violin to existing plot
#  violin_plot(normvar2,at=3,add=TRUE,col="green",violin_width=1)

    # geom_boxplot(data=plot_Data, aes(x=factor(cyl), y=mpg, col=factor(cyl))) + 

nihonBoxPlot <- ggplot(nihonData, aes(x = Type, y = Rank, fill = Type)) +
  geom_boxplot(width = 0.2) +
  # geom_point(data=nihonData[nihonData$Rank > nihonData$upper.limit | nihonData$Rank < nihonData$lower.limit,], aes(x=Type, y=Rank, fill = Type)) +
  # stat_summary(fun = "median", geom = "point", size = 3, color = "gray") +
  # stat_summary(fun = "mean", geom = "point", size = 1, color = "red") +
  labs(title=" ", x=" ", y=" ", fill = " ")  + theme_bw()

# print(nihonBoxPlot)

basicBoxPlot <- ggplot(basicData, aes(x = Type, y = Rank, fill = Type)) +
  geom_boxplot(width = 0.2) +
  # stat_summary(fun = "median", geom = "point", size = 3, color = "gray") +
  # stat_summary(fun = "mean", geom = "point", shape = 18, size = 3, color = "gray26") +
  labs(title=" ", x=" ", y=" ", fill = " ")  + theme_bw()

print(basicBoxPlot)