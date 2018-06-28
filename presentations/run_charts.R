require(ggplot2)
require(reshape2)
require(magrittr)
require(ggthemes)
require(tidyr)

BASE_PATH = "/home/ericbarnhill/Documents/code/insight/rtr/presentations"
setwd("/home/ericbarnhill/Documents/code/insight/rtr/presentations")
for (story in dir(file.path(BASE_PATH, "stories"))) {
    story_path <- file.path(BASE_PATH, "stories", story)
    for (n in 1:3) {
        chart = read.csv(file.path(story_path, paste0("chart_",n,".csv"))) 
        chart$IE <- chart$IE / chart$IE[which(chart$Year == "2014")]
        chart$WoS <- chart$WoS / chart$WoS[which(chart$Year == "2014")]
        chart <- gather(chart, key = App, value = Value, -Year)
        chart$App <- factor(chart$App, levels=c("WoS", "IE"))
        plt <- ggplot(data = chart) + 
            geom_bar(aes(x=Year, y=Value, group=App, fill=App), 
                     stat="identity", position="dodge") +
            scale_y_continuous(limits = c(0,2), expand=c(0,0)) +
            scale_x_continuous(breaks = c(2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017)) + 
            ylab("Term Count (normalized to 2014)") +
            theme_classic()
        print(plt)
        filename = file.path(story_path, paste0("plot_", n, ".png"))
        ggsave(filename, plt)
    }
}
