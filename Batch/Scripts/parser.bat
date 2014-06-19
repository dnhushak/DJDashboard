set program_path=c:\Users\Alex\Desktop\KureITunesParser.jar
set file_path="c:\iTunes Library.xml"
set build_subsonic_csv=false

start javaw -jar %program_path% %file_path% %build_subsonic_csv%
