# -*- coding: utf-8 -*-
"""
Created on Mon Feb 26 12:23:09 2018

@author: alok_
"""


import numpy as np
import pandas as pd
import sklearn as sk
import seaborn as sbrn
import matplotlib.pyplot as plt
import pylab
from datetime import datetime

Applications_data = pd.read_csv('C:/Users/alok_/OneDrive/MBA Academics/Fourth Semester/DSO 562 - Fraud Analytics/Project/Project 2/new_applicationsV3.csv',parse_dates=True, dayfirst=True)
Applications_data2 = pd.read_csv('C:/Users/alok_/OneDrive/MBA Academics/Fourth Semester/DSO 562 - Fraud Analytics/Project/Project 2/new_applicationsV3.csv')

Applications_data.columns

Applications_data = Applications_data.drop('Unnamed: 0',axis=1)

Applications_data.rename(index=str, columns={"newdob": "DOB", "newssn": "SSN"},inplace=True)


Applications_data.describe()
Applications_data.info() 
Applications_data.head(50)

sbrn.heatmap(Applications_data.isnull(),yticklabels=False,cbar=False,cmap='viridis')
sbrn.heatmap(Applications_data.corr(),annot=False)


Applications_data['appdate'] = pd.to_datetime(Applications_data['appdate'])
Applications_data['DOB'] = pd.to_datetime(Applications_data['DOB'],format='%m/%d/%Y',errors='coerce')

Applications_data.firstname.nunique()
Applications_data.lastname.nunique()
Applications_data.address.nunique()
Applications_data.zip5.nunique()
Applications_data.homephone.nunique()
Applications_data.fraud.nunique()
Applications_data.appdate.nunique()
Applications_data.DOB.nunique()
Applications_data.SSN.nunique()

Applications_data.appdate.min()
Applications_data.appdate.max()

Applications_data.DOB.min()
Applications_data.DOB.max()


sbrn.boxplot(Applications_data['zip5'])
sbrn.distplot(Applications_data['zip5'],bins=250)
Applications_data.groupby('zip5').count()['﻿record'].sort_values(ascending=False).head(20)
Applications_data.groupby('zip5').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')


Applications_data.groupby('firstname').count()['﻿record'].sort_values(ascending=False).head(20)
Applications_data.groupby('firstname').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')


Applications_data.groupby('lastname').count()['﻿record'].sort_values(ascending=False).head(20)
Applications_data.groupby('lastname').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')

Applications_data.groupby('address').count()['﻿record'].sort_values(ascending=False).head(20)
Applications_data.groupby('address').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')

sbrn.boxplot(Applications_data['homephone'])
sbrn.distplot(Applications_data['homephone'],bins=250)
Applications_data.groupby('homephone').count()['﻿record'].sort_values(ascending=False).head(20)
Applications_data.groupby('homephone').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')

sbrn.boxplot(Applications_data['fraud'])
sbrn.distplot(Applications_data['fraud'],bins=250)
Applications_data.groupby('fraud').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')

sbrn.boxplot(Applications_data['appdate'])
sbrn.distplot(Applications_data['appdate'],bins=250)
Applications_data.groupby('appdate').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')

sbrn.boxplot(Applications_data['DOB'])
sbrn.distplot(Applications_data['DOB'],bins=250)
Applications_data.groupby('DOB').count()['﻿record'].sort_values(ascending=False).head(20)
Applications_data.groupby('DOB',pd.Grouper(freq='M')).count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')

sbrn.boxplot(Applications_data['SSN'])
sbrn.distplot(Applications_data['SSN'],bins=250)
Applications_data.groupby('SSN').count()['﻿record'].sort_values(ascending=False).head(20)
Applications_data.groupby('SSN').count()['﻿record'].sort_values(ascending=False).head(20).plot(kind='barh')



