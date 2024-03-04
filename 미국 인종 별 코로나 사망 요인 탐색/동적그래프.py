import pandas as pd
import geopandas as gpd
import matplotlib
import PIL
import io
data = pd.read_csv('time_series_covid19_confirmed_US.csv')

# Group the data by the state
data = data.groupby('Province_State').sum()

# Drop Late and Long Columns
data = data.drop(columns = ['Lat', 'Long_'])
data = data.drop(columns = ['UID','code3','FIPS'])

# Create a transpose of the dataframe
data_transposed = data.T
#data_transposed.plot(y= ['Alabama','New York'], use_index = True, figsize = (10,10), marker='*')

us= gpd.read_file(r'C:/COVID-19-master/csse_covid_19_data/csse_covid_19_time_series/US_County_Boundaries.shp')

#for index, row in data.iterrows():
#    if index not in us['STATE'].to_list():
#        print(index + ' :is not in the list')
#    else:
#        pass

merge = us.join(data, on = 'STATE', how = 'right')
merge = merge.drop(columns = ['CTFIPS','STFIPS','VERSION']) 
merge = merge.drop('STATE' == ['American Samoa','Diamond Princess', 'Grand Princess', 'Guam','Northern Marina Islands', 'Virgin Islands'])   
'''
ax = merge.plot(column= '5/22/20',
                    cmap = 'OrRd',
                    figsize = (14,14),
                    legend = True,
                    scheme = 'user_defined',
                    classification_kwds = {'bins':[10,50,100,500,1000,5000,10000,50000,100000]},
                    edgecolor = 'black',
                    linewidth = 0.4)
'''
image_frames = []

for dates in merge.columns.to_list()[5:146]:
    # plot
    ax = merge.plot(column= dates,
                    cmap = 'OrRd',
                    figsize = (14,14),
                    legend = True,
                    scheme = 'user_defined',
                    classification_kwds = {'bins':[10,50,100,500,1000,5000,10000,50000,100000]},
                    edgecolor = 'black',
                    linewidth = 0.4)


    # Add a title to the map
    ax.set_title('Total Confirmed COVID-19 Cases :'+ dates, fontdict = 
                 {'fontsize':20}, pad = 12.5)

    # Removing the axes
    ax.set_axis_off()

    # Move the legend
    ax.get_legend().set_bbox_to_anchor((0.18,0.6))
    
    img = ax.get_figure()
    
    f = io.BytesIO()
    img.savefig(f, format = 'png', bbox_inches ='tight')
    f.seek(0)
    image_frames.append(PIL.Image.open(f))
    


# Create a GIF animation
image_frames[0].save('Dynamic COVID-19 Map.gif', format = 'GIF', append_images = image_frames[1:],
                     save_all = True, duration = 300,
                     loop = 1)
f.close()
 
