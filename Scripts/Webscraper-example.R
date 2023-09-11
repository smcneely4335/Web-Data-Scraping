### Scrape data from a website ###
### Date: September 10, 2023

## load and install packages
# from pacman package: use function p_load(), which installs and loads packages
pacman::p_load(tidyverse, rvest)

# use the read_html() function to read the specific URL you're wanting to look at
webpage <- read_html('https://scrapeme.live/shop')

# pull out elements of interest
html_prods <- webpage %>% 
  html_elements('li.product')

## extract data from the list of products and store them in 4 separate lists
# get the product URLs
prod_urls <- html_prods %>% 
  html_element('a') %>% 
  html_attr('href')

# extract the image URLs
prod_images <- html_prods %>% 
  html_element('img') %>% 
  html_attr('src')

prod_names <- html_prods %>% 
  html_element('h2') %>% 
  html_text()

prod_prices <- html_prods %>% 
  html_element('span') %>% 
  html_text()

# join the product vectors into a dataframe
prod_data <- data.frame(prod_urls, prod_images, prod_names, prod_prices)

# change the names of the dataframe
colnames(prod_data) <- c('url', 'image', 'name', 'price')

# view the dataframe
view(prod_data)
