# About

This is a Dockerfile and a Github Action used to build a custom docker image of [PHP 8](https://www.php.net/) for my purely Docker powered web stack. It's configured with most everything you'd need to run things like a self-hosted [Wordpress](https://wordpress.org/) or [Nextcloud](https://nextcloud.com/).

# PHP Overview

PHP is a general-purpose scripting language geared towards web development. It was originally created by Danish-Canadian programmer Rasmus Lerdorf in 1993 and released in 1995. The PHP reference implementation is now produced by the PHP Group. PHP was originally an abbreviation of Personal Home Page, but it now stands for the recursive acronym PHP: Hypertext Preprocessor.

PHP code is usually processed on a web server by a PHP interpreter implemented as a module, a daemon or a Common Gateway Interface (CGI) executable. On a web server, the result of the interpreted and executed PHP code—which may be any type of data, such as generated HTML or binary image data—would form the whole or part of an HTTP response. Various web template systems, web content management systems, and web frameworks exist that can be employed to orchestrate or facilitate the generation of that response. Additionally, PHP can be used for many programming tasks outside the web context, such as standalone graphical applications and drone control. PHP code can also be directly executed from the command line.

The standard PHP interpreter, powered by the Zend Engine, is free software released under the PHP License. PHP has been widely ported and can be deployed on most web servers on a variety of operating systems and platforms.

The PHP language has evolved without a written formal specification or standard, with the original implementation acting as the de facto standard that other implementations aimed to follow.

# About this Docker Build

I've cobbled this thing together from a half dozen Google searches.  I'm still not totally happy with it but it seems to work well enough to power my few PHP sites.

Most importantly, it's always going to pick the latest version of PHP so at least security issues can be avoided.
