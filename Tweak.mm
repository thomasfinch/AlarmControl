#import <UIKit/UIKit.h>
#import <objc/Runtime.h>
#import "AlarmViewController.h"
#import "AlarmTableViewCell.h"

static UIBarButtonItem *alarmToggleButton;
static BOOL alarmState = YES, hasToggled = NO;
static NSMutableArray *alarms;
static UITableView *tableView;

%hook AlarmViewController

-(id)init
{
    self = %orig;
    alarmToggleButton = [[UIBarButtonItem alloc] initWithTitle:@"Toggle Alarms" style:UIBarButtonItemStylePlain target:self action:@selector(alarmToggleButtonPressed)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.navigationItem.rightBarButtonItem,alarmToggleButton,nil];
    alarms = [[NSMutableArray alloc] init];
    return self;
}

-(id)tableView:(id)view cellForRowAtIndexPath:(id)indexPath
{
    if(!tableView)
        tableView = view;
    return %orig;
}

%new
-(void)alarmToggleButtonPressed
{
    if (!hasToggled)
    {
        int alarmOnCount = 0;
        for (int i = 0; i < [alarms count]; i++)
            if ([[alarms objectAtIndex:i] isActive])
                alarmOnCount++;
        
        alarmState = (alarmOnCount >= [alarms count]-alarmOnCount);
        hasToggled = YES;
    }
    
    alarmState = !alarmState;
    
    for(Alarm *alarm in alarms)
        [self activeChangedForAlarm:alarm active:alarmState];
    [tableView reloadData];
}

%end

%hook Alarm

-(id)initWithSettings:(id)settings
{
    id orig = %orig;
    if (![alarms containsObject:orig])
        [alarms addObject:orig];
    return orig;
}

-(id)initWithDefaultValues
{
    id orig = %orig;
    if (![alarms containsObject:orig])
        [alarms addObject:orig];
    return orig;
}

%end