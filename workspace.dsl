workspace "Test" "This is a test"

!identifiers hierarchical

model {
    user = person "Volunteer" "Person helping Sail as a Volunteer"
    admin = person "Admin" "Administrator of Sail system"

    ss = softwareSystem "Sail Volunteer App" {
        app = container "Mobile Application" "The main interface for the volunteers to interact with the app"


        service1 = group "Authentication Service" {
            as = container "Authentication Microservice"
            asdb = container "Authentication Database" {
                tags "Database"
            }
        }
        service2 = group "Schedule Service" {
            sch = container "Schedule Microservice"
            schdb = container "Schedule Database" {
                tags "Database"
            }
        }
        service3 = group "Program Service" {
            ps = container "Program Microservice"
            psdb = container "Program Database" {
                tags "Database"
            }
        }
        service4 = group "Chat Service" {
            cs = container "Chat Microservice"
            csdb = container "Chat Database" {
                tags "Database"
            }
        }
        service5 = group "Map Service" {
            ms = container "Map Microservice"
            msdb = container "Map Database" {
                tags "Database"
            }
        }
        
    }

    ss2 = softwareSystem "test system" {
        cms = container "Web CMS" "Admin interface for managing app content"
    }
    // App
    user -> ss "Uses"
    user -> ss.app "Uses"
    admin -> ss2 "Uses"
    admin -> ss2.cms "Manages content through"

    //App interactions
    ss.app -> ss.as "Authentication [JSON/HTTP]"
    ss.app -> ss.sch "Fetches schedule information [JSON/HTTP]"
    ss.app -> ss.ps "Fetches program data [JSON/HTTP]"
    ss.app -> ss.cs "Handles chat functions [JSON/HTTP]"
    ss.app -> ss.ms "Interacts with map [JSON/HTTP]"

    // Admin interactions
    ss2.cms -> ss.as "Uses for admin authentication"
    ss2.cms -> ss.sch "Manages schedule data"
    ss2.cms -> ss.ps "Manages program data"
    ss2.cms -> ss.ms "Manages map data"

    // Databases
    ss.as -> ss.asdb
    ss.sch -> ss.schdb
    ss.ps -> ss.psdb
    ss.cs -> ss.csdb
    ss.ms -> ss.msdb
}

views {
    systemContext ss "SystemContext" {
        include user admin ss ss2
        autolayout lr
    }

    container ss "ContainerView" {
        include *
        autolayout lr
    }

    styles {
        element "Element" {
            color #ffffff
        }
        element "Person" {
            background #9b191f
            shape person
        }
        element "Software System" {
            background #ba1e25
        }
        element "Container" {
            background #d9232b
        }
        element "Database" {
            shape cylinder
        }
    }
}

}