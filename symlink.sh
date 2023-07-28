for a in {01..12}
do
    #dias
    for i in {01..31}
    do
        recorddir="${1:-/var/spool/asterisk/monitor/2023/$a/$i}"

        cd $recorddir;
        for file in *.mp3; do
            wav=$(basename "$file" .mp3).wav;
            ln -s "$file" "$wav";
        done
    done
done

