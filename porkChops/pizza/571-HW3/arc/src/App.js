import React from 'react';
import * as ReactDOM from 'react-dom';
import {Map} from '@esri/react-arcgis';
import {Scene} from '@esri/react-arcgis';
import {WebMap,WebScene} from '@esri/react-arcgis';
import Campus from './Campus';

console.log(React.version)

// function App() {
//  ReactDOM.render(
//   <WebMap id="9693531ef10f48d9a2af54515a70fe02" style={{width:'30vw',height:'50vh',border:'1px solid black',margin:'10px'}} />, 
//   // <Map style={{width:'30vw',height:'50vh',border:'1px solid black',margin:'10px'}}/> ,
//   document.getElementById('container')
//  );// ReactDOM.render()
// }// App()

/* <WebMap id="6627e1dd5f594160ac60f9dfc411673f" /> */

// function App() {
//   ReactDOM.render(
//     <Scene /> ,
//     document.getElementById('container')
//   );
//  }// App()

// function App(){
//   ReactDOM.render(
//     <div style={{ width: '100vw', height: '100vh' }}>
//       <WebMap id='9693531ef10f48d9a2af54515a70fe02'>
//         <Campus/>
//       </WebMap>
//     </div>,
//     document.getElementById('container')
//   );
// }

// export default App;

function App() {
  // like we started out with
  ReactDOM.render(
    <Scene /> ,
    document.getElementById('container')
  );
  }// App()
  
  // INSTEAD of 'export default App;'
  export default (props) => (
      <Scene style={{ width: '70vw', height: '90vh' }}
          //mapProperties={{ basemap: 'satellite' }}
          viewProperties={{
              center: [-118.28538,34.0205],
              zoom: 15
          }}>
          <Campus />
      </Scene>
  )
  
