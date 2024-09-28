workspace "Test" "This is a test"

!identifiers hierarchical

model {
    u = person "Volunteer" "Person helping Sail as a Volunteer"
    ss = softwareSystem "Sail Volunteer App" {
        app = container "Mobile Application"
        service1 = group "Chat Service" {
            cs = container "Chat Microservice"
            cdb = container "Chat Database" {
                tags "Database"
            }
        }
        service2 = group "Authentication Service" {
            as = container "Authentication Microservice"
            adb = container "Authentication Database" {
                tags "Database"
            }
        }
    }
    // App
    u -> ss "Uses"
    u -> ss.app "Uses"
    // Chat service
    ss.cs -> ss.cdb "Reads from and writes to"
    ss.app -> ss.cs "Does chat functions using [JSON/HTTP]"
    // Authentication Service
    ss.as -> ss.adb "Reads from and writes to"
    ss.app -> ss.as "Does authentication function using [JSON/HTTP]"
    // ss.app -> ss.s1 "HTTP(S)/TCP"
    // ss1.s1 -> ss1.s2 "GraphQL"
    // ss1.wa -> ss1.s2 "Pidgeon"
}

views {
    systemContext ss "Diagram1" {
        include u ss
        autolayout lr
    }

    container ss "Diagram2" {
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