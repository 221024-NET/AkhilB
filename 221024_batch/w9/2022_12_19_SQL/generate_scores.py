#!/usr/bin/env python3
from random import randrange, choices
from datetime import date, timedelta
import sys
def main(scores):
    """Generate n number of random scores for the 23 restaurants in the Restaurant table
       Also generate random dates YYYY-MM-DD for those n scores within the year 2022
       Also pick a number from 1 to 23 (inclusive) to choose which restaurant gets which score
    """
    #get our dates
    datestart, dateend = date(2022, 1, 1), date(2022, 12, 31)
    #list of dates to pick from
    dates = [datestart]
    #fill out the possible dates
    while datestart != dateend:
        datestart += timedelta(days=1)
        dates.append(datestart)

    #(<1-24>, <0-100>, 'YYYY-MM-DD')
    for i in range(scores):
        s='('
        s+=str(randrange(1,24))
        s+=', '
        s+=str(randrange(101))
        s+=', \''
        scoredate = choices(dates)[0]
        s+= str(scoredate.year) + '-' 
        s+= (str(scoredate.month) if len(str(scoredate.month))==2 else ('0' + str(scoredate.month))) + '-'
        s+= (str(scoredate.day) if len(str(scoredate.day))==2 else ('0' + str(scoredate.day))) + '\')'
        print(s)
        

if __name__=='__main__':
    main(100)
