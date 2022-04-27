library(janitor)
library(tidyverse)
library(here)

cius_data <- read_csv(here("outputs/data/cleaned_data_v1.csv"))


#demography

demo_dat <- cius_data %>% select(
  PROVINCE,
  G_EDUC,
  GENDER,
  AGE_GRP,
  LAN_Q01,
  EMP,
  BPR_Q16,
  VS_USER,
  GV_USER,
  SN_USER,
  SM_USER
)%>% rename(province=PROVINCE,
            education_level=G_EDUC,
            gender=GENDER,
            age_group=AGE_GRP,
            official_language_proficient=LAN_Q01,
            employment_status=EMP,
            is_immigrant=BPR_Q16,
            video_streaming_use=VS_USER,
            gov_serv_use=GV_USER,
            social_ntwk_use=SN_USER,
            smartphone_use=SM_USER)

#internet access

access_dat <- cius_data %>% select(
  AC_160A, #used internet
  AC_180A, #access at home
)%>% rename(uses_internet=AC_160A,
            home_internet_access=AC_180A)

#internet use

usage_dat <- cius_data %>% select(
  UI_210A, #hours used
  UI_220A, #device type smartphone
  UI_220B, #device type laptop
  UI_220C, #device type tablet
  UI_220D, #device type other mobile device
  UI_220E, #device type desktop
  UI_220F, #device type media streaming device
  UI_220G, #device type other internet device
  UI_241A, #communication type email
  UI_241B, #communication type im
  UI_241C, #communication type social network
  UI_241D, #communication type voice/video call
  UI_241E, #communication type dating svc
  UI_241F, #communication type content publishing
  UI_241G, #communication type blog
  UI_241H, #communication type none
  UI_242A, #information type news
  UI_242B, #information type weather
  UI_242C, #information type directions/maps
  UI_242D, #information type research
  UI_242E, #information type none
  UI_243A, #entertainment type music
  UI_243B, #entertainment type podcasts
  UI_243C, #entertainment type streaming svc
  UI_243D, #entertainment type video-sharing sites
  UI_243E, #entertainment type sports subscription
  UI_243F, #entertainment type television stream
  UI_243G, #entertainment type books/magazines
  UI_243H, #entertainment type video games
  UI_243I, #entertainment type gambling
  UI_243J, #entertainment type none
  UI_244A, #commerce type new purchases
  UI_244B, #commerce type second hand purchases
  UI_244C, #commerce type trading goods
  UI_244D, #commerce type final products
  UI_244E, #commerce type none
  UI_245A, #other activities job search
  UI_245B, #other activities online banking
  UI_245C, #other activities virtual wallet
  UI_245D, #other activities institutional training
  UI_245E, #other activities informal trainig
  UI_245F, #other activities making donation
  UI_245G, #other activities booking appointments
  UI_245H, #other activities scheduling classes
  UI_245I #other activities none
)%>% rename(hours_used=UI_210A, #hours used
            smartphone=UI_220A, #device type smartphone
            laptop=UI_220B, #device type laptop
            tablet=UI_220C, #device type tablet
            other_mobile=UI_220D, #device type other mobile device
            desktop=UI_220E, #device type desktop
            media_streaming_device=UI_220F, #device type media streaming device
            other_devices=UI_220G, #device type other internet device
            email=UI_241A, #communication type email
            instant_msg=UI_241B, #communication type im
            social_ntwk=UI_241C, #communication type social network
            voice_video_call=UI_241D, #communication type voice/video call
            dating_svc=UI_241E, #communication type dating svc
            content_publish=UI_241F, #communication type content publishing
            blogging=UI_241G, #communication type blog
            no_communication=UI_241H, #communication type none
            news=UI_242A, #information type news
            weather=UI_242B, #information type weather
            directions=UI_242C, #information type directions/maps
            research=UI_242D, #information type research
            no_information=UI_242E, #information type none
            music=UI_243A, #entertainment type music
            podcast=UI_243B, #entertainment type podcasts
            media_streaming=UI_243C, #entertainment type streaming svc
            video_sharing=UI_243D, #entertainment type video-sharing sites
            sports_sub=UI_243E, #entertainment type sports subscription
            tv_sub=UI_243F, #entertainment type television stream
            reading=UI_243G, #entertainment type books/magazines
            video_games=UI_243H, #entertainment type video games
            gambling=UI_243I, #entertainment type gambling
            no_entertainment=UI_243J, #entertainment type none
            new_goods=UI_244A, #commerce type new purchases
            secondhand_goods=UI_244B, #commerce type second hand purchases
            trading_goods=UI_244C, #commerce type trading goods
            financial_products=UI_244D, #commerce type financial products
            no_commerce=UI_244E, #commerce type none
            job_search=UI_245A, #other activities job search
            online_banking=UI_245B, #other activities online banking
            virtual_wallet=UI_245C, #other activities virtual wallet
            institutional_training=UI_245D, #other activities institutional training
            informal_training=UI_245E, #other activities informal trainig
            donations=UI_245F, #other activities making donation
            appointments=UI_245G, #other activities booking appointments
            scheduling=UI_245H, #other activities scheduling classes
            no_other_activities=UI_245I) #other activities none

#online work

work_dat <- cius_data %>% select(
  OW_740A, #income from internet
  OW_740B, #major income
  OW_740C #extra income
)%>% rename(internet_income=OW_740A, #income from internet
            major_source_income=OW_740B, #major income
            additional_source_income=OW_740C) #extra income

#internet connection

connection_dat <- cius_data %>% select(
  HA_780A, #household connection type - fiber
  HA_780B, #household connection type - cable
  HA_780C, #household connection type - dsl
  HA_780D, #household connection type - dial-up
  HA_780E, #household connection type - mobile data
  HA_780F, #household connection type - LTE hotspot
  HA_780G, #household connection type - fixed wireless p2p
  HA_780H, #household connection type - satellite
  HA_780I, #household connection type - municipal wireless
  HA_780J, #household connection type - other
  HA_780K, #household connection type - none
  HA_780L, #household connection type - don't know
  HA_790A #connection speed
) %>% rename(fiber_optics=HA_780A, #household connection type - fiber
             cable=HA_780B, #household connection type - cable
             dsl=HA_780C, #household connection type - dsl
             dial_up=HA_780D, #household connection type - dial-up
             mobile_data=HA_780E, #household connection type - mobile data
             lte=HA_780F, #household connection type - LTE hotspot
             fixed_wireless_p2p=HA_780G, #household connection type - fixed wireless p2p
             satellite=HA_780H, #household connection type - satellite
             municipal_wireless=HA_780I, #household connection type - municipal wireless
             other=HA_780J, #household connection type - other
             none=HA_780K, #household connection type - none
             unknown=HA_780L, #household connection type - don't know
             connection_speed=HA_790A) #connection speed

cius_data_v2 <- cbind(demo_dat,access_dat,usage_dat,work_dat,connection_dat)

write_csv(cius_data_v2, here("outputs/data/cleaned_data_v2.csv"))
