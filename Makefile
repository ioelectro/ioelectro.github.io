# Generate Dir
generate-dir 		= gh-pages

default : compile

# Compice C prog using GCC
compile :
	rm -rf build
	mkdir build
	gcc htmixer.c -o ./build/htmixer

# Remove Compiled app and Generated files
clean :
	rm -rf $(generate-dir)
	rm -rf build

# Deploy on Github Pages, branch [gh-pages]
# more on : https://pypi.org/project/ghp-import/
# Add CNAME by '-c SITENAME' command
deploy:
	ghp-import -c ioelectro.ir -p $(generate-dir)

##################################### GENARATE ########################################
# Use 'build/htmixer' for mix 'Doc' and 'Var' files.
# for Example: htmixer OUTPUT_FILR -d DOC1 DOC2 -v VAR1 VAR2 VAR3
# The Var replace by same name in Doc file

# Blog Posts
# The 'blog-post-name' must same the .txt file in 'var/blog/post' folder
blog-post-name = compile-c-project design-3d-altium-component-by-solidworks learn-git-for-beginners \
disable-driver-signature-enforcement how-to-download-compile-and-program-avr-project \
ion-implantation  negative-voltage-generator-circuit st-vscode

# Shop Posts
# The 'blog-post-name' must same the .txt file in 'var/blog/post' folder
shop-post-name = water-pump-timer

# Start Generate Static Web Pages
generate :
	rm -rf $(generate-dir)
	mkdir $(generate-dir)

# Make Dir
	mkdir $(generate-dir)/blog
	mkdir $(generate-dir)/shop
	mkdir $(generate-dir)/about
	mkdir $(generate-dir)/contacts
	mkdir $(foreach dir,$(blog-post-name),./$(generate-dir)/blog/$(dir))
	mkdir $(foreach dir,$(shop-post-name),./$(generate-dir)/shop/$(dir))

# Copy Doc css and other files
	cp -r doc/css $(generate-dir)
	cp -r doc/fonts $(generate-dir)
	cp -r doc/img $(generate-dir)
	CP -r doc/blog/upload $(generate-dir)/blog/upload
	CP -r doc/shop/upload $(generate-dir)/shop/upload

# Home
	./build/htmixer ./$(generate-dir)/index.html \
	-d ./doc/header.html ./doc/home.html ./doc/footer.html \
	-v ./var/home.txt ./var/com.txt ./var/footer.txt

# About
	./build/htmixer ./$(generate-dir)/about/index.html \
	-d ./doc/header.html ./doc/about.html ./doc/footer.html \
	-v ./var/about.txt ./var/com.txt ./var/footer.txt

# Contacts
	./build/htmixer ./$(generate-dir)/contacts/index.html \
	-d ./doc/header.html ./doc/contacts.html ./doc/footer.html \
	-v ./var/contacts.txt ./var/com.txt ./var/footer.txt

# Blog
	./build/htmixer ./$(generate-dir)/blog/index.html \
	-d ./doc/header.html ./doc/blog.html ./doc/footer.html \
	-v ./var/blog.txt ./var/com.txt ./var/footer.txt

# Blog post
	for post in $(blog-post-name);do \
	./build/htmixer ./$(generate-dir)/blog/$$post/index.html \
	-d ./doc/header.html ./doc/post.html ./doc/footer.html \
	-v ./var/blog/$$post.txt ./var/com.txt ./var/footer.txt;done

# Shop
	./build/htmixer ./$(generate-dir)/shop/index.html \
	-d ./doc/header.html ./doc/shop.html ./doc/footer.html \
	-v ./var/shop.txt ./var/com.txt ./var/footer.txt

# Shop post
	for post in $(shop-post-name);do \
	./build/htmixer ./$(generate-dir)/shop/$$post/index.html \
	-d ./doc/header.html ./doc/product.html ./doc/footer.html \
	-v ./var/shop/$$post.txt ./var/com.txt ./var/footer.txt;done


