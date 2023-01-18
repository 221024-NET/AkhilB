import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment'

@Injectable({
  providedIn: 'root'
})
export class RestaurantService {
  baseurl: string = `${environment.baseUrl}/api/Restaurant`;

  constructor(private http: HttpClient) { }

  getRestaurants() {
    // TODO : Inject the right URL
    return this.http.get
  }
}
