export { matchers } from './matchers.js';

export const nodes = [
	() => import('./nodes/0'),
	() => import('./nodes/1'),
	() => import('./nodes/2'),
	() => import('./nodes/3'),
	() => import('./nodes/4'),
	() => import('./nodes/5'),
	() => import('./nodes/6'),
	() => import('./nodes/7'),
	() => import('./nodes/8'),
	() => import('./nodes/9'),
	() => import('./nodes/10'),
	() => import('./nodes/11'),
	() => import('./nodes/12'),
	() => import('./nodes/13'),
	() => import('./nodes/14'),
	() => import('./nodes/15'),
	() => import('./nodes/16'),
	() => import('./nodes/17'),
	() => import('./nodes/18')
];

export const server_loads = [];

export const dictionary = {
		"/": [2],
		"/home": [3],
		"/home/assets/addAsset": [4],
		"/home/assets/addUnit": [5],
		"/home/assets/assetVendorInfo": [6],
		"/home/assets/viewInvo": [7],
		"/home/contact": [8],
		"/home/maintainance": [9],
		"/home/maintainance/schedule": [10],
		"/home/reports/assetMaster": [11],
		"/home/reports/assetStatus": [12],
		"/home/reports/sparesMaster": [13],
		"/home/spares/addSpares": [14],
		"/home/spares/spareVendorInfo": [16],
		"/home/spares/sparesInvo": [15],
		"/signup": [17],
		"/updateinvo": [18]
	};

export const hooks = {
	handleError: (({ error }) => { console.error(error) }),

	reroute: (() => {})
};

export { default as root } from '../root.svelte';