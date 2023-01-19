import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment'
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Restaurant, Restaurant2 } from '../models/restaurant';

@Injectable({
  providedIn: 'root'
})
export class RestaurantService {
  baseurl: string = `${environment.baseUrl}/Restaurant`;

  constructor(private http: HttpClient) { }

  public getRestaurants(): Observable<Restaurant[]> {
    return this.http.get<Restaurant[]>(this.baseurl, {headers: environment.headers})
      .pipe(map((restaurants: Restaurant[]) => restaurants.map(r => new Restaurant2(r))));
  }

  public getRestaurant(rID: number) {
    return this.http.get<Restaurant>(`${this.baseurl}/${rID}`);
  }
}
