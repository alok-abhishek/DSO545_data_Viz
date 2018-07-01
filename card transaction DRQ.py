# -*- coding: utf-8 -*-
"""
Created on Sat Mar 31 16:19:59 2018

@author: alok_
"""

import numpy as np
import pandas as pd
import seaborn as sbrn
import matplotlib.pyplot as plt
from datetime import datetime
import plotly.plotly as py
import plotly.graph_objs as go
import calendar


Txn_data = pd.read_csv('C:/Users/alok_/OneDrive/MBA Academics/Fourth Semester/DSO 562 - Fraud Analytics/Project/Project 3/card transactions.csv')

Txn_data.describe()
Txn_data.drop(['Unnamed: 10'], axis=1, inplace=True)

Txn_data.info() 

""""
Txn_data.info() 
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 96708 entries, 0 to 96707
Data columns (total 10 columns):
Recordnum            96708 non-null int64
Cardnum              96708 non-null int64
Date                 96708 non-null object
Merchantnum          93333 non-null object
Merch Description    96708 non-null object
Merchant State       95513 non-null object
Merchant Zip         92052 non-null float64
Transtype            96708 non-null object
 Amount              96708 non-null object
Fraud                96708 non-null int64
dtypes: float64(1), int64(3), object(6)
memory usage: 7.4+ MB
"""
Txn_data.head()

sbrn.heatmap(Txn_data.isnull(),yticklabels=False,cbar=False,cmap='viridis')

sbrn.heatmap(Txn_data.corr(),annot=False)

Txn_data.columns
#Index(['Recordnum', 'Cardnum', 'Date', 'Merchantnum', 'Merch Description','Merchant State', 'Merchant Zip', 'Transtype', ' Amount ', 'Fraud'],dtype='object')

Txn_data.rename({'Merch Description':'Merch_Description', 'Merchant State':'Merchant_State','Merchant Zip':'Merchant_Zip',' Amount ':'Amount'}, axis=1,inplace=True)

Txn_data['Date'] = pd.to_datetime(Txn_data['Date'],format='%m/%d/%Y',errors='coerce')

Txn_data.Merchant_State.nunique()
sbrn.boxplot(Txn_data['Merchant_State'])
sbrn.distplot(Txn_data['Merchant_State'],bins=250)
Txn_data.groupby('Merchant_State').count()['Recordnum'].sort_values(ascending=False).head(20)
Txn_data.groupby('Merchant_State').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='barh')

Txn_data.Merchant_Zip.nunique()
sbrn.boxplot(Txn_data['Merchant_Zip'])
sbrn.distplot(Txn_data['Merchant_Zip'],bins=250)
Txn_data.groupby('Merchant_Zip').count()['Recordnum'].sort_values(ascending=False).head(20)
Txn_data.groupby('Merchant_Zip').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='barh')

Txn_data.Date.nunique()

Txn_data['count'] = 1
Txn_data['month'] = Txn_data.Date.dt.month
Txn_data['month_name'] = Txn_data['month'].apply(lambda x: calendar.month_name[x])

Txn_data['weekday_name'] = Txn_data.Date.dt.weekday_name
Txn_data['day'] = Txn_data.Date.dt.day


sbrn.distplot(Txn_data['month'], hist=True, kde = False)

Txn_data.groupby('weekday_name').count()['Recordnum'].sort_values(ascending=False).plot(kind='bar')

Txn_data.groupby('month_name').count()['Recordnum'].sort_values(ascending=False).plot(kind='bar')

Txn_data.groupby('Transtype').count()['Recordnum'].sort_values(ascending=False).plot(kind='barh')
Txn_data.groupby('Transtype').count()['Recordnum'].sort_values(ascending=False)
Txn_data.Fraud.nunique()

Txn_data.groupby('Fraud').count()['Recordnum'].sort_values(ascending=False).plot(kind='barh')
Txn_data.groupby('Fraud').count()['Recordnum'].sort_values(ascending=False)
Txn_data.Fraud.nunique()

Txn_data['Amount']=(Txn_data['Amount'].replace( '[\$,)]','', regex=True ).replace( '[(]','-',   regex=True ).astype(float))

sbrn.distplot(Txn_data['Amount'],bins=250)
Txn_data.groupby('Amount').count()['Recordnum'].sort_values(ascending=False)
Txn_data.groupby('Amount').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='bar')
sbrn.boxplot(Txn_data['Amount'])
sbrn.jointplot("Amount", "count", data=Txn_data, kind="reg")
Txn_data.index[Txn_data[Txn_data['Amount'] == max(Txn_data['Amount'])].index]

Txn_data.drop(Txn_data.index[Txn_data[Txn_data['Amount'] == max(Txn_data['Amount'])].index], axis=0,inplace=True)

max(Txn_data['Amount'])
min(Txn_data['Amount'])
np.mean(Txn_data['Amount'])
np.std(Txn_data['Amount'])

Txn_data.Amount.nunique()

sbrn.distplot(Txn_data['Amount'],bins=250)
Txn_data.groupby('Amount').count()['Recordnum'].sort_values(ascending=False)
Txn_data.groupby('Amount').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='bar')
sbrn.boxplot(Txn_data['Amount'])
plt.hist(Txn_data['Amount'],bins=50,range=[0,2500])

Txn_data['FedEx'] = Txn_data['Merch_Description'].apply(lambda x: x.find("FEDEX"))
Txn_data['FedEx'] = Txn_data['FedEx']+1
Txn_data.groupby('Merch_Description').count()['Recordnum'].sort_values(ascending=False)

Txn_data['STAPLES'] = Txn_data['Merch_Description'].apply(lambda x: x.find("STAPLES"))
Txn_data['Goverment'].nunique()

Txn_data['STAPLES'] = Txn_data['STAPLES']+1

Txn_data['AMAZON'] = Txn_data['Merch_Description'].apply(lambda x: x.find("AMAZON"))
Txn_data['AMAZON'].nunique()
Txn_data.groupby('AMAZON').count()['Recordnum'].sort_values(ascending=False)
Txn_data['AMAZON']=(Txn_data['AMAZON'].replace( 4.0,0.0, regex=True ).astype(float))
Txn_data['AMAZON'] = Txn_data['AMAZON']+1


Txn_data['Goverment'] = Txn_data['Merch_Description'].apply(lambda x: x.find("GSA" or "GOVERNMENT"))
Txn_data['Goverment'].nunique()
Txn_data.groupby('Goverment').count()['Recordnum'].sort_values(ascending=False)
Txn_data['Goverment']=(Txn_data['Goverment'].replace( 17.0,0.0, regex=True ).replace( 3.0,0.0,regex=True ).replace( 12.0,0.0,regex=True ).astype(float))
Txn_data['Goverment'] = Txn_data['Goverment']+1

Txn_data.to_csv('C:/Users/alok_/OneDrive/MBA Academics/Fourth Semester/DSO 562 - Fraud Analytics/Project/Project 3/card_transactions_updated.csv', encoding='utf-8')

Txn_data2 = pd.read_csv('C:/Users/alok_/OneDrive/MBA Academics/Fourth Semester/DSO 562 - Fraud Analytics/Project/Project 3/card_transactions_updated.csv')

Txn_data2.describe()

Txn_data2.info()

Txn_data2['Date'] = pd.to_datetime(Txn_data2['Date'],format='%m/%d/%Y',errors='coerce')

Txn_data2.Amount.nunique()

Txn_data2.drop(['Unnamed: 0'], axis=1, inplace=True)

Txn_data2.Cardnum.nunique()
Txn_data2.Date.nunique()
Txn_data2.Merchantnum.nunique()
Txn_data2.Merch_Description.nunique()
Txn_data2.Merchant_State.nunique()
Txn_data2.Merchant_Zip.nunique()
Txn_data2.Transtype.nunique()
Txn_data2.Amount.nunique()
Txn_data2.Fraud.nunique()

Txn_data2.Date.min()
Txn_data2.Date.max()

Txn_data.Amount.max()
Txn_data.Amount.min()

Txn_data2.Merchant_State.nunique()
sbrn.boxplot(Txn_data2['Merchant_State'])
sbrn.distplot(Txn_data2['Merchant_State'],bins=250)
Txn_data2.groupby('Merchant_State').count()['Recordnum'].sort_values(ascending=False).head(200)
Txn_data2.groupby('Merchant_State').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='barh')

Txn_data2.Merchant_Zip.nunique()
sbrn.boxplot(Txn_data2['Merchant_Zip'])
sbrn.distplot(Txn_data2['Merchant_Zip'],bins=250)
Txn_data2.groupby('Merchant_Zip').count()['Recordnum'].sort_values(ascending=False).head(20)
Txn_data2.groupby('Merchant_Zip').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='barh')

Txn_data.Merchant_Zip.max()
Txn_data.Merchant_Zip.min()


Txn_data2.Transtype.nunique()
sbrn.boxplot(Txn_data2['Transtype'])
sbrn.distplot(Txn_data2['Transtype'],bins=250)
Txn_data2.groupby('Transtype').count()['Recordnum'].sort_values(ascending=False).head(20)
Txn_data2.groupby('Transtype').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='pie')

Txn_data2.assign(trx = np.ones(numrecords)).set_index(Txn_data2['Date']).resample(dt.timedelta.count().trx.plot(title = 'Daily Transactions')

Txn_data2.Merchantnum.nunique()
sbrn.boxplot(Txn_data2['Merchantnum'])
sbrn.distplot(Txn_data2['Merchantnum'],bins=250)
Txn_data2.groupby('Merchantnum').count()['Recordnum'].sort_values(ascending=False).head(20)
Txn_data2.groupby('Merchantnum').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='barh')

Txn_data2.Cardnum.nunique()
sbrn.boxplot(Txn_data2['Cardnum'])
sbrn.distplot(Txn_data2['Cardnum'],bins=250)
Txn_data2.groupby('Cardnum').count()['Recordnum'].sort_values(ascending=False).head(20)
Txn_data2.groupby('Cardnum').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='barh')

sbrn.boxplot(Txn_data2['Amount'])

Txn_data2.Merch_Description.nunique()
sbrn.boxplot(Txn_data2['Merch_Description'])
sbrn.distplot(Txn_data2['Merch_Description'],bins=250)
Txn_data2.groupby('Merch_Description').count()['Recordnum'].sort_values(ascending=False).head(20)
Txn_data2.groupby('Merch_Description').count()['Recordnum'].sort_values(ascending=False).head(20).plot(kind='barh')

Txn_data2['Merch_Description_2'] = Txn_data2['Merch_Description']
Txn_data2['Merch_Description_2'] = Txn_data2['Merch_Description_2'].apply(lambda x: x.find("FEDEX"))

"""
FedEx                96707 non-null int64
Goverment            96707 non-null float64
STAPLES              96707 non-null int64
AMAZON               96707 non-null float64
"""

Txn_data2.groupby('FedEx').count()['Recordnum'].sort_values(ascending=False).plot(kind='barh')
Txn_data2.groupby('Goverment').count()['Recordnum'].sort_values(ascending=False).plot(kind='barh')
Txn_data2.groupby('STAPLES').count()['Recordnum'].sort_values(ascending=False).plot(kind='barh')
Txn_data2.groupby('AMAZON').count()['Recordnum'].sort_values(ascending=False).plot(kind='barh')

Txn_data2.groupby('FedEx').count()['Recordnum'].sort_values(ascending=False)
Txn_data2.groupby('Goverment').count()['Recordnum'].sort_values(ascending=False)
Txn_data2.groupby('STAPLES').count()['Recordnum'].sort_values(ascending=False)
Txn_data2.groupby('AMAZON').count()['Recordnum'].sort_values(ascending=False)

sbrn.distplot(Txn_data2['Amount'],bins=150)

tmp = Txn_data2[Txn_data2['Amount']<=500]
tmp = tmp[tmp['BLDFRONT']<=100]

sbrn.distplot(tmp['Amount'],bins=350)

