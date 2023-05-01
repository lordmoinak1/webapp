import requests
import json

manifestHeader = ['downloadServerUrl=https://public.cancerimagingarchive.net/nbia-download/servlet/DownloadServlet', 
                  'includeAnnotation=true',
                  'noOfrRetry=4',
                  'databasketId=NSCLC-Radiomics-Test.tcia',
                  'manifestVersion=3.0',
                  'ListOfSeriesToDownload=',
                  '1.3.6.1.4.1.32722.99.99.298991776521342375010861296712563382046',
                  '1.3.6.1.4.1.32722.99.99.227938121586608072508444156170535578236',
                  '1.2.276.0.7230010.3.1.3.2323910823.20524.1597260509.554',
                  '1.3.6.1.4.1.32722.99.99.232988001551799080335895423941323261228',
                  '1.2.276.0.7230010.3.1.3.2323910823.11504.1597260515.421',
                  '1.3.6.1.4.1.32722.99.99.243267551266911245830259417117543245931',
                  '1.3.6.1.4.1.32722.99.99.238922279929619243990469813419868528595',
                  '1.2.276.0.7230010.3.1.3.2323910823.23864.1597260522.316',
                  '1.3.6.1.4.1.32722.99.99.217589447746111741056421838759223122712']

baseurl='https://services.cancerimagingarchive.net/nbia-api/services/v1/'

def restCall(url,itemName):
  response = requests.get(baseurl+url)
  if len(response.text)==0:
    return []
  retList = [] 
  for d in response.json():
    if itemName in d:
      retList.append(d[itemName])
  return retList

## creates a TCIA file with the provided series list. 
def createTCIAmanifest(outputFileName,listOfSeriesToDownload,databasketId='manifest-1646842161649.tcia'):
  """  
    outputFileName: outputFileName
    databasketId: dataID needed by TCIA to download from 
    listOfSeriesToDownload:  listOfSeriesToDownload
  """
  manifestHeader = ['downloadServerUrl=https://public.cancerimagingarchive.net/nbia-download/servlet/DownloadServlet', 
                  'includeAnnotation=true',
                  'noOfrRetry=4',
                  'manifestVersion=3.0']
  manifestHeader.extend(['databasketId='+databasketId])
  manifestHeader.extend(['ListOfSeriesToDownload='])
  manifestHeader.extend(listOfSeriesToDownload)
  with open(outputFileName, 'w') as f:
    for line in manifestHeader:
      f.write(line)
      f.write('\n')

if __name__ == "__main__":
  flag = 0

  # pickedCollection, pickedModality = 'C4KC-KiTS','SEG'
  # seriesLst = restCall('getSeries?Collection='+pickedCollection+'&Modality='+pickedModality,'SeriesInstanceUID')
  # print (len(seriesLst))
  # ## pick the first 10 for the demo
  # seriesLst2Download=seriesLst[:5]

  # tciaFileName = pickedCollection+'.tcia'
  # createTCIAmanifest(tciaFileName, seriesLst2Download)

  # print(tciaFileName)

  # import os
  # cmd = '/opt/nbia-data-retriever/nbia-data-retriever --cli /content/C4KC-KiTS.tcia -d /content/ -f'
  # os.system(cmd)

