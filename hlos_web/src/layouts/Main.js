import React from "react";
import { Switch, Route, Redirect } from "react-router-dom";
// creates a beautiful scrollbar
//import PerfectScrollbar from "perfect-scrollbar";
import "perfect-scrollbar/css/perfect-scrollbar.css";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";
// core components
import Navbar from "components/Navbars/Navbar.js";
import Footer from "components/Footer/Footer.js";
import Sidebar from "components/Sidebar/Sidebar.js";
//import FixedPlugin from "components/FixedPlugin/FixedPlugin.js";

import routes from "routes.js";

import styles from "assets/jss/material-dashboard-react/layouts/adminStyle.js";

import bgImage from "assets/img/sidebar.jpg";
import logo from "assets/img/android-chrome-192x192.png";

// Perfect ScrollBar variable: let ps;

// Create a state object.  The data is saved in this after creating an instance.
function createStateInstance() {
  var state = {};
  return {
    save: function(key, value) {
      state = {
        ...state,
        [key]:value
      }
      //console.log(state);
    },
    restore: function() {
      return state;
    }
  }
}
const globalState = createStateInstance();

const switchRoutes = (
  <Switch>
    {routes.map((prop, key) => {
      if (prop.layout === "/main") {
        return (
          <Route
            path={prop.layout + prop.path}
            // Not using this because we want to pass in our own props for the global state
            //component={prop.component}
            key={key}
            render={props => <prop.component {...props} state={globalState} />}
          />
        );
      }
      return null;
    })}
    <Redirect from="/main" to="/main/services" />
  </Switch>
);

const useStyles = makeStyles(styles);

export default function Main({ ...rest }) {
  // styles
  const classes = useStyles();
  // ref to help us initialize PerfectScrollbar on windows devices
  const mainPanel = React.createRef();
  // states and functions
/* Mobile and demo constants
  const [image, setImage] = React.useState(bgImage);
  const [color, setColor] = React.useState("blue");
  const [fixedClasses, setFixedClasses] = React.useState("dropdown show");
  const [mobileOpen, setMobileOpen] = React.useState(false);
  const handleImageClick = image => {
    setImage(image);
  };
  const handleColorClick = color => {
    setColor(color);
  };
  const handleFixedClick = () => {
    if (fixedClasses === "dropdown") {
      setFixedClasses("dropdown show");
    } else {
      setFixedClasses("dropdown");
    }
  };
  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };
  */

/*  This one could be useful if something needs to open in 'full screen':
const getRoute = () => {
    return window.location.pathname !== "/admin/maps";
  };
*/
/* Mobile
  const resizeFunction = () => {
    if (window.innerWidth >= 960) {
      setMobileOpen(false);
    }
  };

  // initialize and destroy the PerfectScrollbar plugin
  React.useEffect(() => {
    if (navigator.platform.indexOf("Win") > -1) {
      ps = new PerfectScrollbar(mainPanel.current, {
        suppressScrollX: true,
        suppressScrollY: false
      });
      document.body.style.overflow = "hidden";
    }
    window.addEventListener("resize", resizeFunction);
    // Specify how to clean up after this effect:
    return function cleanup() {
      if (navigator.platform.indexOf("Win") > -1) {
        ps.destroy();
      }
      window.removeEventListener("resize", resizeFunction);
    };
  }, [mainPanel]);
*/
return (
    <div className={classes.wrapper}>
      <Sidebar
        routes={routes}
        logoText={"HomelabOS"}
        logo={logo}
        image={bgImage}
        //handleDrawerToggle={handleDrawerToggle}
        //open={mobileOpen}
        color="orange"
        {...rest}
      />
      <div className={classes.mainPanel} ref={mainPanel}>
        <Navbar
          routes={routes}
          {...rest}
        />

          {/* handleDrawerToggle={handleDrawerToggle} */}

        <div className={classes.content}>
          <div className={classes.container}>{switchRoutes}</div>
        </div>
        <Footer />

        {/* On the /maps route we want the map to be on full screen - this is not possible if the content and container classes are present because they have some paddings which would make the map smaller */}
{/*
        {getRoute() ? (
          <div className={classes.content}>
            <div className={classes.container}>{switchRoutes}</div>
          </div>
        ) : (
          <div className={classes.map}>{switchRoutes}</div>
        )}
        {getRoute() ? <Footer /> : null}
*/}
{/*
        <FixedPlugin
          handleImageClick={handleImageClick}
          handleColorClick={handleColorClick}
          bgColor={color}
          bgImage={image}
          handleFixedClick={handleFixedClick}
          fixedClasses={fixedClasses}
        />
*/}
      </div>
    </div>
  );
}
