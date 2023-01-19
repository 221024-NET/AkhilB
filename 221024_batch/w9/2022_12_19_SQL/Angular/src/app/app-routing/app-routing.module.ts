import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { RestaurantComponent } from '../components/restaurant/restaurant.component';

const routes: Routes = [
  { path: '', redirectTo: '/restaurant', pathMatch: 'full' },
  { path: 'restaurant', component: RestaurantComponent },
];

@NgModule({
  declarations: [],
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
