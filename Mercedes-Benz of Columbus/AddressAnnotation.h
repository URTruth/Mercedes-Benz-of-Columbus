//
//  AddressAnnotation.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

- (NSString *)subtitle;
- (NSString *)title;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@end
