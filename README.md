# R Interface to D-Place

An R interface to the anthropology database, [D-Place](https://d-place.org).

## Installation
To install from this repository:

```r
require(devtools)
install_github("matthewgthomas/dplacer")
library(dplacer)
```

## Usage
At the moment, the package can do the following:

1. Fetch details about the full set of societies in D-Place:

```r
societies <- dplace_all_societies()
head(societies)

#     id ext_id  xd_id           name        original_name alternate_names focal_year region language.id
# 1  843   Ah12  xd301       Basakomo      Basakomo (Ah12)      Bassa-Komo       1920      8           1
# 2  842   Ah11  xd300           Basa          Basa (Ah11)           Bassa       1950      8           1
# 3  600    Sf8 xd1381           Piro           Piro (Sf8)          Nomole       1950     48           2
# 4 1877    B13  xd907 Agta (Isabela) Agta (Isabela) (B13)                       1979     27           3
# 5  930   Ai47  xd378            Mao           Mao (Ai47)                       1939     10           4
# 6  931 SCCS32  xd378            Mao         Mao (SCCS32)                       1939     NA           4
#    language.name language.glotto_code language.iso_code language.family.id language.family.scheme
# 1 Basa (Nigeria)             basa1282               bzw                  1                      G
# 2 Basa (Nigeria)             basa1282               bzw                  1                      G
# 3           Yine             yine1238               pib                  2                      G
# 4   Agta-Pahanan             agta1234               apf                  3                      G
# 5           Hozo             hozo1236               hoz                  4                      G
# 6           Hozo             hozo1236               hoz                  4                      G
#   language.family.name language.family.language_count source.id source.year  source.author
# 1       Atlantic-Congo                            314         1        1999 Murdock et al.
# 2       Atlantic-Congo                            314         1        1999 Murdock et al.
# 3             Arawakan                             14         1        1999 Murdock et al.
# 4         Austronesian                            139         4        2001        Binford
# 5                  Mao                              1         1        1999 Murdock et al.
# 6                  Mao                              1         2        1969        Murdock
#                                                                                                                                                                                source.reference
# 1                                            Murdock, G. P., R. Textor, H. Barry, III, D. R. White, J. P. Gray, and W. T. Divale. 1999. Ethnographic Atlas. World Cultures 10:24-136 (codebook)
# 2                                            Murdock, G. P., R. Textor, H. Barry, III, D. R. White, J. P. Gray, and W. T. Divale. 1999. Ethnographic Atlas. World Cultures 10:24-136 (codebook)
# 3                                            Murdock, G. P., R. Textor, H. Barry, III, D. R. White, J. P. Gray, and W. T. Divale. 1999. Ethnographic Atlas. World Cultures 10:24-136 (codebook)
# 4 Binford, L. 2001. Constructing Frames of Reference: An Analytical Method for Archaeological Theory Building Using Hunter-gatherer and Environmental Data Sets. University of California Press
# 5                                            Murdock, G. P., R. Textor, H. Barry, III, D. R. White, J. P. Gray, and W. T. Divale. 1999. Ethnographic Atlas. World Cultures 10:24-136 (codebook)
# 6                                                                                                                                                                                              
#               source.name location.coordinates.x location.coordinates.y
# 1      Ethnographic Atlas                   7.00                   8.00
# 2      Ethnographic Atlas                   8.00                   8.00
# 3      Ethnographic Atlas                 -73.00                 -12.00
# 4 Binford Hunter-Gatherer                 122.05                  17.48
# 5      Ethnographic Atlas                  35.00                   9.00
# 6                                             NA                     NA
#   original_location.coordinates.x original_location.coordinates.y
# 1                            7.00                            8.00
# 2                            8.00                            8.00
# 3                          -73.00                          -12.00
# 4                          122.05                           17.48
# 5                           35.00                            9.00
# 6                              NA                              NA
```

2. Get data about an individual society:

```r
saami <- dplace_society("Cg4")
head(saami)
# $soc_name
# [1] "Sami (Cg4)"
# 
# $soc_source
# [1] "Ethnographic Atlas"
# 
# $original_name
# [1] "Lapps (Cg4)"
# 
# $lang_family
# [1] "Uralic"
# 
# $lang_dialect
# [1] "Lule Sami "
# 
# $alt_names
# [1] "Lapps"
```

3. Fetch cultural codes and variables:

```r
codes <- dplace_codes()
vars <- dplace_variables()
```

If you use this package to download a lot of data from D-Place, please remember to [scrape responsibly](https://news.ycombinator.com/item?id=12345693)!

More features to come!
