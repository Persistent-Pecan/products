# products

This is a system design project I've done in Hack Reactor. We built up a backend system to support the full data set for a e-commerce product page. And my part is to provide optimized server side service for front end's product, photos, styles, and related items. 

## Setup
+ Run npm install to install dependencies.
+ Run npm start to get the server started.
+ Run npm test to test the server.

## How to Get Started
This project has been deployed on AWS:EC2. To run it locally, you need to connect with the AWS database using authentication info.

## Service Routes
+ **/products**  -get info from all products. By default, it only shows first 5 products in page 1, you can alter the default by changing the count and page in url
+ **/products/:product_id**  -get the product info by specific product_id
+ **/products/:product_id/styles**  -get the styles and photos from the product by product_id
+ **/products/:product_id/related**  -get related products of this specific product_id
