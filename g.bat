@echo off

if "%1"=="b"      goto bootstrap               
if "%1"=="br"     goto bug-report              
if "%1"=="cl"      goto clean                   
if "%1"=="co"      goto compile                 
if "%1"=="con"      goto console                 
if "%1"=="ca"     goto create-app              
if "%1"=="cc"     goto create-controller       
if "%1"=="cdc"    goto create-domain-class     
if "%1"=="cit"    goto create-integration-test 
if "%1"=="cp"     goto create-plugin           
if "%1"=="csc"     goto create-script           
if "%1"=="cs"     goto create-service          
if "%1"=="ctl"    goto create-tag-lib          
if "%1"=="cut"    goto create-unit-test        
if "%1"=="d"      goto doc                     
if "%1"=="ga"     goto generate-all            
if "%1"=="gc"     goto generate-controller     
if "%1"=="gv"     goto generate-views          
if "%1"=="h"      goto help                    
if "%1"=="i"      goto init                    
if "%1"=="ip"     goto install-plugin          
if "%1"=="it"     goto install-templates       
if "%1"=="lp"     goto list-plugins            
if "%1"=="p"      goto package                 
if "%1"=="pp"     goto package-plugin          
if "%1"=="pi"     goto plugin-info             
if "%1"=="rp"     goto release-plugin          
if "%1"=="ra"     goto run-app                 
if "%1"=="rah"    goto run-app-https           
if "%1"=="rw"     goto run-war                 
if "%1"=="sp"     goto set-proxy               
if "%1"=="sv"     goto set-version             
if "%1"=="shell"      goto shell                   
if "%1"=="s"      goto stats                   
if "%1"=="ta"     goto test-app                
if "%1"=="u"      goto upgrade                 
if "%1"=="w"      goto war 
if "%1"==""      goto cmdhelp 

goto normal
goto end

:normal
call grails %1 %2 %3 %4 %5
goto end

:bootstrap
call grails bootstrap               %2 %3 
goto end


:bug-report
call grails bug-report              %2 %3 
goto end


:clean
call grails clean                   %2 %3 
goto end


:compile
call grails compile                 %2 %3 
goto end


:console
call grails console                 %2 %3 
goto end


:create-app
call grails create-app              %2 %3 
goto end


:create-controller
call grails create-controller       %2 %3 
goto end


:create-domain-class
call grails create-domain-class     %2 %3 
goto end


:create-integration-test
call grails create-integration-test %2 %3 
goto end


:create-plugin
call grails create-plugin           %2 %3 
goto end


:create-script
call grails create-script           %2 %3 
goto end


:create-service
call grails create-service          %2 %3 
goto end


:create-tag-lib
call grails create-tag-lib          %2 %3 
goto end


:create-unit-test
call grails create-unit-test        %2 %3 
goto end


:doc
call grails doc                     %2 %3 
goto end


:generate-all
call grails generate-all            %2 %3 
goto end


:generate-controller
call grails generate-controller     %2 %3 
goto end


:generate-views
call grails generate-views          %2 %3 
goto end


:help
call grails help                    %2 %3 
goto end


:init
call grails init                    %2 %3 
goto end


:install-plugin
call grails install-plugin          %2 %3 
goto end


:install-templates
call grails install-templates       %2 %3 
goto end


:list-plugins
call grails list-plugins            %2 %3 
goto end


:package
call grails package                 %2 %3 
goto end


:package-plugin
call grails package-plugin          %2 %3 
goto end


:plugin-info
call grails plugin-info             %2 %3 
goto end


:release-plugin
call grails release-plugin          %2 %3 
goto end


:run-app
call grails run-app                 %2 %3  -server -Xmx800M   -Dserver.port=80
rem -Dserver.port=80
goto end


:run-app-https
call grails run-app-https           %2 %3 
goto end


:run-war
call grails run-war                 %2 %3 
goto end


:set-proxy
call grails set-proxy               %2 %3 
goto end


:set-version
call grails set-version             %2 %3 
goto end


:shell
call grails shell                   %2 %3 
goto end


:stats
call grails stats                   %2 %3 
goto end


:test-app
call grails test-app                %2 %3 
goto end


:upgrade
call grails upgrade                 %2 %3 
goto end


:war
call grails war                     %2 %3 

goto end


:cmdhelp
echo ===============================================
echo 使用方法：
echo =============================================== 
echo eg： g b   =    grails bootstrap              
echo eg： g br  =    grails bug-report             
echo eg： g cl  =    grails clean                  
echo eg： g co  =    grails compile                
echo eg： g con =    grails console                
echo eg： g ca  =    grails create-app             
echo eg： g cc  =    grails create-controller      
echo eg： g cdc =    grails create-domain-class    
echo eg： g cit =    grails create-integration-test
echo eg： g cp  =    grails create-plugin          
echo eg： g csc =    grails create-script          
echo eg： g cs  =    grails create-service         
echo eg： g ctl =    grails create-tag-lib         
echo eg： g cut =    grails create-unit-test       
echo eg： g d   =    grails doc                    
echo eg： g ga  =    grails generate-all           
echo eg： g gc  =    grails generate-controller    
echo eg： g gv  =    grails generate-views         
echo eg： g h   =    grails help                   
echo eg： g i   =    grails init                   
echo eg： g ip  =    grails install-plugin         
echo eg： g it  =    grails install-templates      
echo eg： g lp  =    grails list-plugins           
echo eg： g p   =    grails package                
echo eg： g pp  =    grails package-plugin         
echo eg： g pi  =    grails plugin-info            
echo eg： g rp  =    grails release-plugin         
echo eg： g ra  =    grails run-app                
echo eg： g rah =    grails run-app-https          
echo eg： g rw  =    grails run-war                
echo eg： g sp  =    grails set-proxy              
echo eg： g sv  =    grails set-version            
echo eg： g sh  =    grails shell                  
echo eg： g s   =    grails stats                  
echo eg： g ta  =    grails test-app               
echo eg： g u   =    grails upgrade                
echo eg： g w   =    grails war  
echo =============================================== 
echo 不匹配以上任何一种命令，将执行正常的命令语法
echo =============================================== 
goto end

:end 
