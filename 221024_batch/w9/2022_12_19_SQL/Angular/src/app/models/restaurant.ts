import { IRestaurant } from "./restaurantinterface";

export class Restaurant implements IRestaurant 
{
    restID?: number;
    rName?: string;
    rAddress?: string;
    rCity?: string;
    rState?: string;
    grade?: string;

    constructor (restID: number, rName: string, rAddress: string, rCity: string, rState: string, grade: string){
        this.restID=restID;
        this.rName=rName;
        this.rAddress=rAddress;
        this.rCity=rCity;
        this.rState=rState;
        this.grade=grade;
    }
}

export class Restaurant2 implements IRestaurant
{
    restID?: number;
    rName?: string;
    rAddress?: string;
    rCity?: string;
    rState?: string;
    grade?: string;

    constructor (r2: Restaurant){
        this.restID=r2.restID;
        this.rName=r2.rName;
        this.rAddress=r2.rAddress;
        this.rCity=r2.rCity;
        this.rState=r2.rState;
        this.grade=r2.grade;
    }
}