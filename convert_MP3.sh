#!/bin/bash
#mes
for a in {01..12}
do
#dias
for i in {01..31}
do
recorddir="${1:-/var/spool/asterisk/monitor/2023/$a/$i}"

cd $recorddir;
for file in *.wav; do
mp3=$(basename "$file" .wav).mp3;
nice lame -b 16 -m m -q 9-resample "$file" "$mp3";

chown asterisk.asterisk "$mp3";
chmod 444 "$mp3";

rm -f "$file";
done
done
done
