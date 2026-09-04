const vscode = require("vscode");





const THEMES = {





MORNING: "iSheild Morning",





DAY: "iSheild Day",





NIGHT: "iSheild Night",





};





function getPhase() {





const hour = new Date().getHours();





if (hour >= 6 && hour < 12) {





    return "MORNING";





}





if (hour >= 12 && hour < 18) {





    return "DAY";





}





return "NIGHT";





}





async function setTheme(theme) {





const config = vscode.workspace.getConfiguration("workbench");





await config.update(





    "colorTheme",





    theme,





    vscode.ConfigurationTarget.Global





);





}





function activate(context) {





let currentPhase = null;





const applyCurrentTheme = async () => {





const phase = getPhase();





    if (phase === currentPhase) {





        return;





    }





const theme = THEMES[phase];





    try {





        await setTheme(theme);





        console.log(`iSheild → ${phase} → ${theme}`);





        currentPhase = phase;





    } catch (error) {





        console.error("iSheild failed to change theme:", error);





    }





};





// Apply immediately when VS Code starts.





applyCurrentTheme();





// Check periodically for a phase transition.





const timer = setInterval(applyCurrentTheme, 30 * 1000);





context.subscriptions.push({





    dispose() {





        clearInterval(timer);





    },





});





}





function deactivate() {}





module.exports = {





activate,





deactivate,





};