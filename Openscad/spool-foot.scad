use<library.scad>
hole=6;
partthick=14;

module spool_foot()
{
	polyhole(partthick*1.2,hole);
}

spool_foot();