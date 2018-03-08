
yum install lua_devel ncurses ncurses-devel perl-devel perl-ExtUtils-Embed ruby ruby-devel

##./configure --prefix=/usr/local \
CFLAGS="-I/usr/lib64/perl5/CORE/"		#如果报缺少EXTERN.h的错

./configure  \
--with-features=huge \
--enable-luainterp=dynamic \
--enable-perlinterp=dynamic \
--enable-pythoninterp=dynamic \
--enable-python3interp=dynamic \
--enable-tclinterp=dynamic \
--enable-rubyinterp=dynamic \
--enable-cscope \
--enable-multibyte \
--enable-xim \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--with-compiledby="acelee" \
--with-x 

make
make install


#--enable-gui=auto 
#--enable-gnome-check 

#--enable-gui=no

#https://gist.github.com/odiumediae/3b22d09b62e9acb7788baf6fdbb77cf8
#./configure \
#--enable-multibyte \
#--enable-perlinterp=dynamic \
#--enable-rubyinterp=dynamic \
#--with-ruby-command=/usr/local/bin/ruby \
#--enable-pythoninterp=dynamic \
#--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
#--enable-python3interp \
#--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
#--enable-luainterp \
#--with-luajit \
#--enable-cscope \
#--enable-gui=auto \
#--with-features=huge \
#--with-x \
#--enable-fontset \
#--enable-largefile \
#--disable-netbeans \
#--with-compiledby="yourname" \
#--enable-fail-if-missing