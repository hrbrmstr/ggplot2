\name{geom_bar}
\alias{geom_bar}
\alias{GeomBar}
\title{geom\_bar}
\description{Bars, rectangles with bases on x-axis}
\details{
The bar geom is used to produce 1d area plots: bar charts for categorical x, and histograms for continuous y.  stat\_bin explains the details of these summaries in more detail.  In particular, you can use the \code{weight} aesthetic to create weighted histograms and barcharts where the height of the bar no longer represent a count of observations, but a sum over some other variable.  See the examples for a practical example.

By default, multiple x's occuring in the same place will be stacked a top one another by position\_stack.  If you want them to be dodged from side-to-side, check out position\_dodge.  Finally, position\_fill shows relative propotions at each x by stacking the bars and then stretch or squashing them all to the same height

This page describes geom\_bar, see \code{\link{layer}} and \code{\link{qplot}} for how to create a complete plot from individual components.
}
\section{Aesthetics}{
The following aesthetics can be used with geom\_bar.  Aesthetics are mapped to variables in the data with the aes function: \code{geom\_bar(aes(x = var))}
\itemize{
  \item \code{x}: x position (\strong{required}) 
  \item \code{colour}: border colour 
  \item \code{fill}: internal colour 
  \item \code{size}: size 
  \item \code{linetype}: line type 
  \item \code{weight}: observation weight used in statistical transformation 
  \item \code{alpha}: transparency 
}
}
\section{Advice}{
If you have presummarised data, use <code>stat="identity" to turn off the default summary

Sometimes, bar charts are used not as a distributional summary, but instead of a dotplot.  Generally, it's preferable to use a dotplot (see geom\_point) as it has a better data-ink ratio.  However, if you do want to create this type of plot, you can set y to the value you have calculated, and use stat='identity'.

A bar chart maps the height of the bar to a variable, and so the base of the bar must always been shown to produce a valid visual comparison.  Naomi Robbins has a nice <a href='http://www.b-eye-network.com/view/index.php?cid=2468&amp;fc=0&amp;frss=1&amp;ua'>article on this topic</a>.  This is the reason it doesn't make sense to use a log-scaled y axis.

}
\usage{geom_bar(mapping = NULL, data = NULL, stat = "bin", position = "stack", 
    ...)}
\arguments{
 \item{mapping}{mapping between variables and aesthetics generated by aes}
 \item{data}{dataset used in this layer, if not specified uses plot dataset}
 \item{stat}{statistic used by this layer}
 \item{position}{position adjustment used by this layer}
 \item{...}{ignored }
}
\seealso{\itemize{
  \item \code{\link{stat_bin}}: for more details of the binning alogirithm
  \item \code{\link{position_dodge}}: for creating side-by-side barcharts
  \item \code{\link{position_stack}}: for more info on stacking
  \item \url{http://had.co.nz/ggplot2/geom_bar.html}
}}
\value{A \code{\link{layer}}}
\examples{\dontrun{
# Generate data
c <- ggplot(mtcars, aes(factor(cyl)))

c + geom_bar()
c + geom_bar() + coord_flip()
c + geom_bar(fill="white", colour="darkgreen")

# Use qplot
qplot(factor(cyl), data=mtcars, geom="bar")
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(cyl))

# Stacked bar charts    
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(vs))
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(gear))

# Stacked bar charts are easy in ggplot2, but not effective visually, 
# particularly when there are many different things being stacked
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
ggplot(diamonds, aes(color, fill=cut)) + geom_bar() + coord_flip()

# Faceting is a good alternative:
ggplot(diamonds, aes(clarity)) + geom_bar() + 
  facet_wrap(~ cut)
# If the x axis is ordered, using a line instead of bars is another
# possibility:
ggplot(diamonds, aes(clarity)) + 
  geom_freqpoly(aes(group = cut, colour = cut))

# Dodged bar charts    
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar(position="dodge")
# compare with 
ggplot(diamonds, aes(cut, fill=cut)) + geom_bar() + 
  facet_grid(. ~ clarity)

# But again, probably better to use frequency polygons instead:
ggplot(diamonds, aes(clarity, colour=cut)) + 
  geom_freqpoly(aes(group = cut))

# Often we don't want the height of the bar to represent the
# count of observations, but the sum of some other variable.
# For example, the following plot shows the number of diamonds
# of each colour
qplot(color, data=diamonds, geom="bar")
# If, however, we want to see the total number of carats in each colour
# we need to weight by the carat variable
qplot(color, data=diamonds, geom="bar", weight=carat, ylab="carat")

# A bar chart used to display means
meanprice <- tapply(diamonds$price, diamonds$cut, mean)
cut <- factor(levels(diamonds$cut), levels = levels(diamonds$cut))
qplot(cut, meanprice)
qplot(cut, meanprice, geom="bar", stat="identity")
qplot(cut, meanprice, geom="bar", stat="identity", fill = I("grey50"))
}}
\author{Hadley Wickham, \url{http://had.co.nz/}}
\keyword{hplot}
