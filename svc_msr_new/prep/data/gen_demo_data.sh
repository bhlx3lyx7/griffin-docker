#!/bin/bash

./gen_delta_src.sh

src=demo_src
tgt=demo_tgt

rm ${src}
cat demo_basic >> ${src}
cat delta_src >> ${src}

rm ${tgt}
cat demo_basic >> ${tgt}
cat delta_tgt >> ${tgt}
