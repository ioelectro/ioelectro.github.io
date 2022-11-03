# Makefile Template for HTMixer
# by liyanboy74

htmixer		="C:/Program Files (x86)/htmixer/bin/htmixer.exe"
smg         ="C:/Program Files (x86)/smg/bin/smg.exe"

generate-dir = gh-pages
theme        = default-theme

site         = ioelectro.ir

default : generate map
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
	rm -rf $(generate-dir)
	mkdir $(generate-dir)

# Make Dir
	mkdir $(generate-dir)/blog
	mkdir $(generate-dir)/shop
	mkdir $(generate-dir)/about
	mkdir $(generate-dir)/contacts
	mkdir $(generate-dir)/course
	mkdir $(foreach dir,$(blog-post-name),./$(generate-dir)/blog/$(dir))
	mkdir $(foreach dir,$(shop-post-name),./$(generate-dir)/shop/$(dir))
	mkdir $(foreach dir,$(course-post-name),./$(generate-dir)/course/$(dir))

# Copy Doc css and other files
	cp -r $(theme)/css $(generate-dir)
	cp -r $(theme)/js $(generate-dir)
	cp -r $(theme)/fonts $(generate-dir)
	cp -r $(theme)/img $(generate-dir)
	cp -r doc/blog/upload $(generate-dir)/blog
	cp -r doc/shop/upload $(generate-dir)/shop
	cp -r doc/course/upload $(generate-dir)/course

# Home
	$(htmixer) ./$(generate-dir)/index.html \
	-d ./$(theme)/header.html ./$(theme)/home.html ./$(theme)/footer.html \
	-v ./doc/home.txt ./doc/com.txt ./doc/footer.txt

# About
	$(htmixer) ./$(generate-dir)/about/index.html \
	-d ./$(theme)/header.html ./$(theme)/about.html ./$(theme)/footer.html \
	-v ./doc/about.txt ./doc/com.txt ./doc/footer.txt

# Contacts
	$(htmixer) ./$(generate-dir)/contacts/index.html \
	-d ./$(theme)/header.html ./$(theme)/contacts.html ./$(theme)/footer.html \
	-v ./doc/contacts.txt ./doc/com.txt ./doc/footer.txt

# Blog
	$(htmixer) ./$(generate-dir)/blog/index.html \
	-d ./$(theme)/header.html ./$(theme)/blog.html ./$(theme)/footer.html \
	-v ./doc/blog.txt ./doc/com.txt ./doc/footer.txt

# Blog post
	for post in $(blog-post-name);do \
	$(htmixer) ./$(generate-dir)/blog/$$post/index.html \
	-d ./$(theme)/header.html ./$(theme)/post.html ./$(theme)/footer.html \
	-v ./doc/blog/$$post.txt ./doc/com.txt ./doc/footer.txt;done

# Shop
	$(htmixer) ./$(generate-dir)/shop/index.html \
	-d ./$(theme)/header.html ./$(theme)/shop.html ./$(theme)/footer.html \
	-v ./doc/shop.txt ./doc/com.txt ./doc/footer.txt

# Shop post (product)
	for post in $(shop-post-name);do \
	$(htmixer) ./$(generate-dir)/shop/$$post/index.html \
	-d ./$(theme)/header.html ./$(theme)/product.html ./$(theme)/footer.html \
	-v ./doc/shop/$$post.txt ./doc/product-ex.txt ./doc/com.txt ./doc/footer.txt;done

# Course
	$(htmixer) ./$(generate-dir)/course/index.html \
	-d ./$(theme)/header.html ./$(theme)/course.html ./$(theme)/footer.html \
	-v ./doc/course.txt ./doc/com.txt ./doc/footer.txt

# Course post
	for post in $(course-post-name);do \
	$(htmixer) ./$(generate-dir)/course/$$post/index.html \
	-d ./$(theme)/header.html ./$(theme)/course-$$post.html ./$(theme)/footer.html \
	-v ./doc/course/$$post.txt ./doc/com.txt ./doc/footer.txt;done

#################################### SITEMAP ##########################################
map:
	$(smg) -s https://$(site) -n $(generate-dir)/sitemap.xml \
	-d contacts -d about \
	-d course $(addprefix -p,$(course-post-name)) \
	-d shop $(addprefix -p,$(shop-post-name)) \
	-d blog $(addprefix -p,$(blog-post-name))

##################################### DEPLOY ##########################################
# Deploy on Github Pages, branch [gh-pages]
# more on : https://pypi.org/project/ghp-import/
# Add CNAME by '-c SITENAME' command
deploy:
	ghp-import -c $(site) -p $(generate-dir)


#######################################################################################
