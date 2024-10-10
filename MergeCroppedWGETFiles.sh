#!/bin/bash

# Define the regions and their limits
regions=(
    "ClCLME,-150,-110,10,45"
    "CaCLME,-25,-5,10,45"
    "HuCLME,-90,-68,-45,-10"
    "BeCLME,0,20,-45,-10"
)
#!/bin/bash

# Merge files using cdo
cdo mergetime /Volumes/Seagate/Datos/ModelosCMIP6/tos_Omon_*.nc /Volumes/Seagate/Datos/ModelosCMIP6/tos_Omon_EC-Earth3P_highres-future_r3i1p2f1_gn_201501_205012.nc


#echo "Files merged "
# Loop over the regions and extract them using cdo
for region in "${regions[@]}"; do
    # Extract the region name and limits
    IFS=',' read -r region_name lon_min lon_max lat_min lat_max <<< "$region"
    # Extract the region using cdo CESM-H_tos_Omon_CESM_hist-1950_r3i1p2f1.nc'
    cdo sellonlatbox,"$lon_min","$lon_max","$lat_min","$lat_max" /Volumes/Seagate/Datos/ModelosCMIP6/tos_Omon_EC-Earth3P_highres-future_r3i1p2f1_gn_201501_205012.nc "/Volumes/Seagate/Datos/ModelosCMIP6/$region_name"_tos_Omon_EC-Earth3P_highres-future_r3i1p2f1_gn_201501_205012.nc 
    echo "$region_name cropped succesfully"
done

# Remove the original files
rm -r /Volumes/Seagate/Datos/ModelosCMIP6/tos_Omon_*.nc
echo "Original files removed successfully."