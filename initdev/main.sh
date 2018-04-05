#!/bin/bash
	
	Author='CHEKIRED Soumia chekiredsoumia1997@gmail.com'
	version='1.0'
	app_name='initdev_cc'
	description="Premier projet des étudiants en troisième année licence recherche opérationnelle de l'université des sciences et de la technologie Houari Boumediène"
	
	gitinit='0'
	licence='0'
	language='0'
	
	for i in "$@"
	do
	case $i in
	    -C ) language='C' shift ;;
		-CPP | -C++ ) language='CPP' shift ;;
		-Py ) language='Python' shift ;;
		-Latex ) language='Latex' shift ;;
		-BEAMER ) language='BEAMER' shift ;;
		-GPL ) licence='GPL' shift ;;
		-MIT ) licence='MIT' shift ;;
		-git ) gitinit=1 shift ;;
		-help | -h )   echo ""
					   echo "$app_name"
					   echo "$description"
					   echo "Syntaxe: initdev [-arg1] [-arg2] [-arg3] <nom_projet>"
					   echo "-----"
					   echo "Option:"
					   echo "-C projet en language C"
					   echo "-CPP -C++ projet en language C++"
					   echo "-Py projet en language Python"
					   echo "-Latex projet en rédaction en Latex"
					   echo "-BEAMER projet de présentation en BEAMER"
					   echo "-GPL GENRAL PUBLIC LICENCE"
					   echo "-git Initiation d'un dépot git"
					   echo ""
					   echo "Author: $Author"
					   shift 
					   exit 0 ;;
		-version | -v) echo "$app_name version $version"
					   shift 
					   exit 0 ;;
	    -*)
	     echo "Uknown arguments, please check the help : initdev –help"   # unknown option
	    exit 1 ;;
	esac
	done
	
	# Declaration de fonctions
	
	# creation du fichier LICENSE
	function creat_license {
	if [ "$licence" != "0" ]; then
		if [ "$licence" == "GPL" ]; then
			cp $HOME/.initdev/initdev/licenses/GPL GPL
		fi
		if [ "$licence" == "MIT" ]; then
			cp $HOME/.initdev/initdev/licenses/MIT MIT
		fi
	else
		touch LICENSE
	fi
	}
	
	# creation du fichier main
	function creat_main {
	if [ "$language" != "0" ]; then
		if [ "$language" == "C" ]; then
			cp $HOME/.initdev/initdev/sources/main.c main.c
		fi
		if [ "$language" == "CPP" ]; then
			cp $HOME/.initdev/initdev/sources/main.cpp main.cpp
		fi
		if [ "$language" == "Python" ]; then
			cp $HOME/.initdev/initdev/sources/main.py main.py
		fi
		if [ "$language" == "Latex" ]; then
			cp $HOME/.initdev/initdev/sources/latexMin.tex latexMin.tex
		fi
		if [ "$language" == "BEAMER" ]; then
			cp $HOME/.initdev/initdev/sources/beamer.tex beamer.tex
		fi
	else
		touch main
	fi
	}
	
	# initialisation de git
	function git_init {
	if [ "$gitinit" != "0" ]; then
		if [ "$language" != "0" ]; then
			if [ "$language" == "C" ]; then
				cp $HOME/.initdev/initdev/gitignores/c .gitignore
			fi
			if [ "$language" == "CPP" ]; then
				cp $HOME/.initdev/initdev/gitignores/cpp .gitignore
			fi
			if [ "$language" == "Python" ]; then
				cp $HOME/.initdev/initdev/gitignores/python .gitignore
			fi
			if [ "$language" == "Latex" ]; then
				cp $HOME/.initdev/initdev/gitignores/tex .gitignore
			fi
			if [ "$language" == "BEAMER" ]; then
				cp $HOME/.initdev/initdev/gitignores/tex .gitignore
			fi
			git init
		else
			echo "You must set project type, please check the help : initdev –help"
			exit 1
		fi
	fi
	}
	
	#---------------------------
	
	# test nom du projet
	if [ -z "$1" ]; then
		echo "Expected arguments, please check the help : initdev –help"
		exit 1
	fi
	
	
	# creation du projet
	if [ ! -d "$1" ]; then
		
		#creation du repertoire
		mkdir $1
		cd $1
	
		#creation du fichier vide Makefile
		touch Makefile
	
		# functions Calls
		creat_main
		creat_license
		git_init
		
		cd ..
		
		else
		echo "le projet $1 existe déja !"
		exit 1
	fi
