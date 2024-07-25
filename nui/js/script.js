document.addEventListener('DOMContentLoaded', () => {
    const speedValue = document.getElementById('speed-value');
    const fuelBar = document.getElementById('fuel-bar');
    const damageBar = document.getElementById('damage-bar');
    const streetName = document.getElementById('street-name');

    window.addEventListener('message', (event) => {
        if (event.data.type === 'updateHUD') {
            updateSpeed(event.data.speed);
            updateFuel(event.data.fuel);
            updateDamage(event.data.damage);
            updateStreet(event.data.street);
        } else if (event.data.type === 'showHUD') {
            document.getElementById('hud').style.display = event.data.display ? 'block' : 'none';
        }
    });

    function updateSpeed(newSpeed) {
        speedValue.textContent = newSpeed.toFixed(0);
    }

    function updateFuel(newFuel) {
        fuelBar.style.width = newFuel + '%';
        fuelBar.style.backgroundColor = newFuel < 20 ? 'red' : '#FFA500'; // Cambio de color si el combustible es bajo
    }

    function updateDamage(newDamage) {
        damageBar.style.width = newDamage + '%';
    }

    function updateStreet(newStreet) {
        streetName.textContent = newStreet;
    }
});
