# Makefile Template for HTMixer
# by liyanboy74

htmixer      = htmixer
smg          = smg

generate-dir = gh-pages
theme        = default-theme

site         = ioelectro.ir

HTMFlags     = -l1

default : generate cp map
##################################### GENARATE ########################################
# Use 'htmixer' for mix 'Doc' and 'Var' files.
# for Example: htmixer OUTPUT_FILR -d DOC1 DOC2 -v VAR1 VAR2 VAR3
# The Var replace by same name in Doc file

# Blog Posts
# The 'blog-post-name' must same the .txt file in 'doc/blog/post' folder
blog-post-name = $(patsubst %.txt,%,$(notdir $(wildcard ./doc/blog/*.txt)))


# Shop Posts
# The 'shop-post-name' must same the .txt file in 'doc/shop/post' folder
shop-post-name = $(patsubst %.txt,%,$(notdir $(wildcard ./doc/shop/*.txt)))

# Course Posts
# The 'course-post-name' must same the .txt file in 'doc/course/post' folder
# Ech course must have body html file in $(theme) folder named :course-NMAE.html
course-post-name = $(patsubst %.txt,%,$(notdir $(wildcard ./doc/course/*.txt)))

# Start Generate Static Web Pages
generate :
# Home
	$(htmixer) $(HTMFlags) ./$(generate-dir)/index.html \
	-d ./$(theme)/header.html ./$(theme)/home.html ./$(theme)/footer.html \
	-v ./doc/home.txt ./doc/com.txt ./doc/footer.txt

# About
	$(htmixer) $(HTMFlags) ./$(generate-dir)/about/index.html \
	-d ./$(theme)/header.html ./$(theme)/about.html ./$(theme)/footer.html \
	-v ./doc/about.txt ./doc/com.txt ./doc/footer.txt

# Contacts
	$(htmixer) $(HTMFlags) ./$(generate-dir)/contacts/index.html \
	-d ./$(theme)/header.html ./$(theme)/contacts.html ./$(theme)/footer.html \
	-v ./doc/contacts.txt ./doc/com.txt ./doc/footer.txt

# Blog
	$(htmixer) $(HTMFlags) ./$(generate-dir)/blog/index.html \
	-d ./$(theme)/header.html ./$(theme)/blog.html ./$(theme)/footer.html \
	-v ./doc/blog.txt ./doc/com.txt ./doc/footer.txt

# Blog post
	for post in $(blog-post-name);do \
	$(htmixer) $(HTMFlags) ./$(generate-dir)/blog/$$post/index.html \
	-d ./$(theme)/header.html ./$(theme)/post.html ./$(theme)/footer.html \
	-v ./doc/blog/$$post.txt ./doc/com.txt ./doc/footer.txt;done

# Shop
	$(htmixer) $(HTMFlags) ./$(generate-dir)/shop/index.html \
	-d ./$(theme)/header.html ./$(theme)/shop.html ./$(theme)/footer.html \
	-v ./doc/shop.txt ./doc/com.txt ./doc/footer.txt

# Shop post (product)
	for post in $(shop-post-name);do \
	$(htmixer) $(HTMFlags) ./$(generate-dir)/shop/$$post/index.html \
	-d ./$(theme)/header.html ./$(theme)/product.html ./$(theme)/footer.html \
	-v ./doc/shop/$$post.txt ./doc/product-ex.txt ./doc/com.txt ./doc/footer.txt;done

# Course
	$(htmixer) $(HTMFlags) ./$(generate-dir)/course/index.html \
	-d ./$(theme)/header.html ./$(theme)/course.html ./$(theme)/footer.html \
	-v ./doc/course.txt ./doc/com.txt ./doc/footer.txt

# Course post
	for post in $(course-post-name);do \
	$(htmixer) $(HTMFlags) ./$(generate-dir)/course/$$post/index.html \
	-d ./$(theme)/header.html ./$(theme)/course-$$post.html ./$(theme)/footer.html \
	-v ./doc/course/$$post.txt ./doc/com.txt ./doc/footer.txt;done

################################### COPY FILES #######################################
cp:
# Copy Doc css and other files
	cp -r  $(theme)/css $(generate-dir)
	cp -nr $(theme)/js $(generate-dir)
	cp -nr $(theme)/fonts $(generate-dir)
	cp -nr $(theme)/img $(generate-dir)
	cp -nr doc/blog/upload $(generate-dir)/blog
	cp -nr doc/shop/upload $(generate-dir)/shop
	cp -nr doc/course/upload $(generate-dir)/course

##################################### CLEAN ##########################################
clean:
	rm -rf $(generate-dir)
#################################### SITEMAP ##########################################
map:
	$(smg) -s https://$(site) -n $(generate-dir)/sitemap.xml \
	-d contacts -d about \
	-d course $(addprefix -p,$(course-post-name)) \
	-d blog $(addprefix -p,$(blog-post-name)) \
	-d shop $(addprefix -p,$(shop-post-name))


##################################### DEPLOY ##########################################
# Deploy on Github Pages, branch [gh-pages]
# more on : https://pypi.org/project/ghp-import/
# Add CNAME by '-c SITENAME' command
#
# deploy:
# 	ghp-import -c $(site) -p $(generate-dir)


#######################################################################################
