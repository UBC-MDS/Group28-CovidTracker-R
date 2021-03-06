% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_geographical.R
\name{plot_geographical}
\alias{plot_geographical}
\title{Plot Cloropleth Map of Covid Data}
\usage{
plot_geographical(covid_df, metric)
}
\arguments{
\item{covid_df}{dataframe containing covid data to plot}

\item{metric}{unquoted column name of a quantitative variable to plot}
}
\value{
plot object of cloropleth map
}
\description{
Plot Cloropleth Map of Covid Data
}
\examples{
covid_df <- get_covid_data()
plot_geographical(covid_df, cases)
}
