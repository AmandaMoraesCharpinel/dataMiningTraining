Mtcars dataset - Miles per gallon prediction
========================================================
author: Jens Schreiber
date: 2015-10-25
font-import: http://fonts.googleapis.com/css?family=Risque
font-family: 'Risque'
<style>
/* slide titles */
.reveal h3 { 
  font-size: 50px;
  color: blue;
}
.small-code pre code {
  font-size: 20px;
}

/* heading for slides with two hashes ## */
.reveal .slides section .slideContent h2 {
   font-size: 20px;
   font-weight: bold;
   color: green;
}
/* ordered and unordered list styles */
.reveal ul, 
.reveal ol {
    font-size: 30px;
    color: red;
    list-style-type: square;
}
</style>


Agenda
========================================================

This pitch covers the following topics

- Summary of mtcars data
- Boxplot mtcars dataset
- Regression with mtcars


Summary mtcars dataset
========================================================
class: small-code

```r
  summary(mtcars)
```

```
      mpg             cyl             disp             hp       
 Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  
 1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  
 Median :19.20   Median :6.000   Median :196.3   Median :123.0  
 Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7  
 3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0  
 Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0  
      drat             wt             qsec             vs        
 Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000  
 1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000  
 Median :3.695   Median :3.325   Median :17.71   Median :0.0000  
 Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375  
 3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000  
 Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000  
       am              gear            carb      
 Min.   :0.0000   Min.   :3.000   Min.   :1.000  
 1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
 Median :0.0000   Median :4.000   Median :2.000  
 Mean   :0.4062   Mean   :3.688   Mean   :2.812  
 3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
 Max.   :1.0000   Max.   :5.000   Max.   :8.000  
```

Boxplot mtcars dataset
========================================================

![plot of chunk unnamed-chunk-2](presentation-figure/unnamed-chunk-2-1.png) 

Regression with mtcars
========================================================
class: small-code


```r
  fit <- lm(mpg ~ hp + cyl + wt + gear + am, data=mtcars)
  summary(fit)
```

```

Call:
lm(formula = mpg ~ hp + cyl + wt + gear + am, data = mtcars)

Residuals:
    Min      1Q  Median      3Q     Max 
-3.5843 -1.7328 -0.6248  1.2602  5.5846 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 37.18730    6.00091   6.197 1.48e-06 ***
hp          -0.02339    0.01586  -1.475  0.15218    
cyl         -0.80602    0.66416  -1.214  0.23581    
wt          -2.63130    0.94448  -2.786  0.00983 ** 
gear        -0.24116    1.18188  -0.204  0.83991    
am           1.66574    1.73190   0.962  0.34501    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 2.555 on 26 degrees of freedom
Multiple R-squared:  0.8493,	Adjusted R-squared:  0.8203 
F-statistic:  29.3 on 5 and 26 DF,  p-value: 6.687e-10
```
