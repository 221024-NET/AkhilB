import { Component } from '@angular/core';
import { Restaurant, Restaurant2 } from 'src/app/models/restaurant';
import { RestaurantService } from 'src/app/services/restaurant.service';

@Component({
  selector: 'app-restaurant',
  templateUrl: './restaurant.component.html',
  styleUrls: ['./restaurant.component.css']
})
export class RestaurantComponent {
  restaurants: Restaurant[];
  constructor(private restaurantService: RestaurantService){
    this.restaurants = [];
  }

  ngOnInit(){
    this.restaurantService.getRestaurants().subscribe(
      data => {
        this.restaurants = data;
      },
      error => {
        console.log(error);
      }
    )
  }
}
