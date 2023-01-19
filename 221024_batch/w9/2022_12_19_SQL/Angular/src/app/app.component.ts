import { Component } from '@angular/core';
import { RouterModule, Routes, Router } from '@angular/router';
import { RestaurantComponent } from './components/restaurant/restaurant.component';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Angular';
  constructor(private router: Router) { }
  goToRestaurant() {
    this.router.navigate(['/restaurant']);
  }

}
