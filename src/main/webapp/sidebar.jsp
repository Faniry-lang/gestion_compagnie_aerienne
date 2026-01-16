<nav style="
    position: fixed;
    top: 0;
    left: 0;
    width: 200px;
    height: 100vh;
    background: linear-gradient(180deg, #ffffff, #f8fafc);
    color: #0f172a;
    padding: 24px 18px;
    font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
    box-shadow: 4px 0 14px rgba(2,6,23,0.06);
    z-index: 900;
">

    <style>
        .main-content { margin-left: 260px; }

        @media (max-width: 900px) { .main-content { margin-left: 0; } nav { position: relative; width: 100%; height: auto; box-shadow: none; } }
        .sidebar-link { display:flex; align-items:center; padding:10px 12px; border-radius:8px; color:inherit; text-decoration:none; background: transparent; transition: background .12s ease, transform .08s ease; }
        .sidebar-link:hover { background: rgba(2,6,23,0.03); transform: translateY(-1px); }
        .sidebar-icon { margin-right:12px; }
    </style>

    <h1 style="
        margin: 0 0 4px 0;
        font-size: 20px;
        font-weight: 700;
        letter-spacing: 0.5px;
        color: #0f172a;
    ">
        Flight Booking
    </h1>

    <div style="
        margin-bottom: 30px;
        font-size: 12px;
        color: #475569;
        text-transform: uppercase;
        letter-spacing: 2px;
    ">
        BACKOFFICE
    </div>

    <ul style="
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 6px;
    ">

        <li>
            <a href="aeroport" class="sidebar-link">
                <i class="fi fi-rr-flag sidebar-icon" style="color:#0284c7;"></i>
                Aeroports
            </a>
        </li>

        <li>
            <a href="reservation" class="sidebar-link">
                <i class="fi fi-rr-wallet sidebar-icon" style="color:#16a34a;"></i>
                Reservations
            </a>
        </li>

        <li>
            <a href="billet?action=list" class="sidebar-link">
                <i class="fi fi-rr-money sidebar-icon" style="color:#f59e0b;"></i>
                Billets
            </a>
        </li>

        <li>
            <a href="vol" class="sidebar-link">
                <i class="fi fi-rr-plane sidebar-icon" style="color:#3b82f6;"></i>
                Vols
            </a>
        </li>

        <li>
            <a href="tarif-vol?action=list" class="sidebar-link">
                <i class="fi fi-rr-budget-alt sidebar-icon" style="color:#ef4444;"></i>
                Tarifs Vol
            </a>
        </li>

        <li>
            <a href="itineraire" class="sidebar-link">
                <i class="fi fi-rr-route sidebar-icon" style="color:#f43f5e;"></i>
                Itineraires
            </a>
        </li>

        <li>
            <a href="avion" class="sidebar-link">
                <i class="fi fi-rr-airplane-journey sidebar-icon" style="color:#7c3aed;"></i>
                Avions
            </a>
        </li>

        <li>
            <a href="tranche-age?action=list" class="sidebar-link">
                <i class="fi fi-rr-users-alt sidebar-icon" style="color:#8b5cf6;"></i>
                Tranches d'âge
            </a>
        </li>

        <li>
            <a href="remise-age?action=list" class="sidebar-link">
                <i class="fi fi-rr-percentage sidebar-icon" style="color:#ec4899;"></i>
                Remises par âge
            </a>
        </li>
    </ul>
</nav>


