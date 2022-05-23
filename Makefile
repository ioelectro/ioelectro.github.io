# Makefile Template for HTMixer
# by liyanboy74

htmixer		="C:/Program Files (x86)/htmixer/bin/htmixer.exe"
generate-dir=gh-pages

default : generate
##################################### GENARATE ########################################
# Use 'htmixer' for mix 'Doc' and 'Var' files.
# for Example: htmixer OUTPUT_FILR -d DOC1 DOC2 -v VAR1 VAR2 VAR3
# The Var replace by same name in Doc file

# Blog Posts
# The 'blog-post-name' must same the .txt file in 'var/blog/post' folder
blog-post-name = compile-c-project design-3d-altium-component-by-solidworks learn-git-for-beginners \
disable-driver-signature-enforcement how-to-download-compile-and-program-avr-project \
ion-implantation  negative-voltage-generator-circuit st-vscode electric-arc-furnace

# Shop Posts
# The 'shop-post-name' must same the .txt file in 'var/shop/post' folder
shop-post-name = water-pump-timer h01

# Course Posts
# The 'course-post-name' must same the .txt file in 'var/course/post' folder
# Ech course must have pody html file in doc folder named :course-NMAE.html
course-post-name = learn-c

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
	cp -r doc/css $(generate-dir)
	cp -r doc/fonts $(generate-dir)
	cp -r doc/img $(generate-dir)
	cp -r doc/blog/upload $(generate-dir)/blog/upload
	cp -r doc/shop/upload $(generate-dir)/shop/upload
	cp -r doc/course/upload $(generate-dir)/course/upload

# Home
	$(htmixer) ./$(generate-dir)/index.html \
	-d ./doc/header.html ./doc/home.html ./doc/footer.html \
	-v ./var/home.txt ./var/com.txt ./var/footer.txt

# About
	$(htmixer) ./$(generate-dir)/about/index.html \
	-d ./doc/header.html ./doc/about.html ./doc/footer.html \
	-v ./var/about.txt ./var/com.txt ./var/footer.txt

# Contacts
	$(htmixer) ./$(generate-dir)/contacts/index.html \
	-d ./doc/header.html ./doc/contacts.html ./doc/footer.html \
	-v ./var/contacts.txt ./var/com.txt ./var/footer.txt

# Blog
	$(htmixer) ./$(generate-dir)/blog/index.html \
	-d ./doc/header.html ./doc/blog.html ./doc/footer.html \
	-v ./var/blog.txt ./var/com.txt ./var/footer.txt

# Blog post
	for post in $(blog-post-name);do \
	$(htmixer) ./$(generate-dir)/blog/$$post/index.html \
	-d ./doc/header.html ./doc/post.html ./doc/footer.html \
	-v ./var/blog/$$post.txt ./var/com.txt ./var/footer.txt;done

# Shop
	$(htmixer) ./$(generate-dir)/shop/index.html \
	-d ./doc/header.html ./doc/shop.html ./doc/footer.html \
	-v ./var/shop.txt ./var/com.txt ./var/footer.txt

# Shop post
	for post in $(shop-post-name);do \
	$(htmixer) ./$(generate-dir)/shop/$$post/index.html \
	-d ./doc/header.html ./doc/product.html ./doc/footer.html \
	-v ./var/shop/$$post.txt ./var/com.txt ./var/footer.txt;done

# Course
	$(htmixer) ./$(generate-dir)/course/index.html \
	-d ./doc/header.html ./doc/course.html ./doc/footer.html \
	-v ./var/course.txt ./var/com.txt ./var/footer.txt

# Course post
	for post in $(course-post-name);do \
	$(htmixer) ./$(generate-dir)/course/$$post/index.html \
	-d ./doc/header.html ./doc/course-$$post.html ./doc/footer.html \
	-v ./var/course/$$post.txt ./var/com.txt ./var/footer.txt;done


##################################### DEPLOY ##########################################
# Deploy on Github Pages, branch [gh-pages]
# more on : https://pypi.org/project/ghp-import/
# Add CNAME by '-c SITENAME' command
deploy:
	ghp-import -c ioelectro.ir -p $(generate-dir)


#######################################################################################
