SELECT f.rfam_acc, rf.rfamseq_acc
FROM rfamseq rf, family f, full_region fr, taxonomy tx
WHERE f.rfam_acc = fr.rfam_acc
AND fr.rfamseq_acc = rf.rfamseq_acc
AND tx.ncbi_id = rf.ncbi_id
AND tx.species like '%Homo sapiens (human)%';

