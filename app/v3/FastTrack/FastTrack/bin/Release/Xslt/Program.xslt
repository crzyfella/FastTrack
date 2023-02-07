<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="track" select="/Program/Races/Race[1]/Info/TrackName"/>
	<xsl:variable name="trackCd" select="/Program/Races/Race[1]/Info/TrackCd"/>
	<xsl:variable name="raceDate" select="/Program/Races/Race[1]/Info/RaceDt"/>
	<xsl:output method="html"/>
	<xsl:template match="/Program/Races">
		<html lang="en">
			<head>
				<meta charset="UTF-8" />
				<meta http-equiv="X-UA-Compatible" content="IE=edge" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<title>Program</title>
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
					integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous" />
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
				<style>
					.no-margin
					{
					margin: 0px !important;
					}
				</style>
			</head>

			<body class="px-3">
				<header>
					<div class="container-fluid pt-3">
						<div class="row-cols-1 fs-1 fw-bold border border-2 border-dark">
							<div class="ms-3 me-3">
								<p>
									Track: <xsl:value-of select="$track"></xsl:value-of>
								</p>
								<p>
									Date: <xsl:value-of select="$raceDate"></xsl:value-of>
								</p>
							</div>
						</div>
					</div>
				</header>
				<xsl:for-each select="Race">
					<section class="p-2">
						<div class="container-fluid border border-2 border-dark">
							<div class="row">
								<div class="col-1">
									<div class="container d-flex align-items-center justify-content-center w-100 h-100">
										<h3 class="fw-bold">
											<xsl:value-of select="Info/RaceNum"></xsl:value-of>
										</h3>
									</div>
								</div>
								<div class="col">
									<p class="no-margin">
										<span class="fw-bold">Furlong: </span><xsl:value-of select="Info/Furlong"></xsl:value-of>
									</p>
									<p class="no-margin">
										<span class="fw-bold">Surface: </span><xsl:value-of select="Info/Surface"></xsl:value-of>
									</p>
									<p class="no-margin">
										<xsl:value-of select="Info/RaceCondition"></xsl:value-of>
									</p>
								</div>
							</div>
							<xsl:for-each select="Horses/Horse">
								<div class="row m-3 border border-2 border-dark py-3">
									<div class="col-3">
										<p class="no-margin">
											<span class="fw-bold">Post Position: </span>
											<xsl:value-of select="Info/PostPosition"/>
										</p>
										<p>
											<span class="fw-bold">Horse Name: </span>
											<xsl:value-of select="Info/HorseName"/>
										</p>
									</div>
									<div class="col-3">
										<div class="container" style="width: 90%;">
											<div class="row">
												<div class="col-2 fw-bold">
													<xsl:value-of select="Info/CurrentRecordYear"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/CurrentRecordStarts"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/CurrentRecordWins"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/CurrentRecordPlaces"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/CurrentRecordShows"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/CurrentRecordEarning"/>
												</div>
											</div>
											<div class="row">
												<div class="col-2 fw-bold">
													<xsl:value-of select="Info/PreviousRecordYear"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/PreviousRecordStarts"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/PreviousRecordWins"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/PreviousRecordPlaces"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/PreviousRecordShows"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/PreviousRecordEarning"/>
												</div>
											</div>
											<div class="row">
												<div class="col-2 fw-bold">
													<xsl:value-of select="$trackCd"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayTrackStarts"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayTrackWins"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayTrackPlaces"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayTrackShows"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayTrackEarning"/>
												</div>
											</div>
											<div class="row">
												<div class="col-2 fw-bold">Wet</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeWetRecordStarts"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeWetRecordWins"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeWetRecordPlaces"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeWetRecordShows"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeWetRecordEarning"/>
												</div>
											</div>
											<div class="row">
												<div class="col-2 fw-bold">Turf</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeTurfRecordStarts"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeTurfRecordWins"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeTurfRecordPlaces"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeTurfRecordShows"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeTurfRecordEarning"/>
												</div>

											</div>
											<div class="row">
												<div class="col-2 fw-bold">Dist</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayDistanceStarts"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayDistanceWins"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayDistancePlaces"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayDistanceShows"/>
												</div>
												<div class="col-2">
													<xsl:value-of select="Info/LifeTimeRecordTodayDistanceEarning"/>
												</div>

											</div>
										</div>
									</div>
									<div class="col-3">
										<div class="container" style="width: 90%;">
											<p class="no-margin">
												<span class="fw-bold">Jockey: </span>
												<xsl:value-of select="Info/Jockey"/>
											</p>
											<p class="no-margin">
												<span class="fw-bold">Current Year: </span>
												<xsl:value-of select="Info/JockeyRecordCurrentYear"/>
											</p>
											<p class="no-margin">
												<span class="fw-bold">Previous Year: </span>
												<xsl:value-of select="Info/JockeyRecordPreviousYear"/>
											</p>
										</div>
									</div>
									<div class="col-3">
										<div class="container">
											<p class="no-margin">
												<span class="fw-bold">Trainer: </span>
												<xsl:value-of select="Info/Trainer"/>
											</p>
											<p class="no-margin">
												<span class="fw-bold">Current Year: </span>
												<xsl:value-of select="Info/TrainerRecordCurrentYear"/>
											</p>
											<p class="no-margin">
												<span class="fw-bold">Previous Year: </span>
												<xsl:value-of select="Info/TrainerRecordPreviousYear"/>
											</p>
										</div>
									</div>
									<div class="col-12 w-100">
										<h5 class="fw-bold">Past Performances</h5>
										<div class="container-fluid">
											<table class="table table-borderless m-2 align-middle" style="font-size: 12px;">
												<tbody>
													<xsl:for-each select="PastPerformances/PastPerformance">
														<tr>
															<td class="fw-bold" style="width: 1%;">
																<xsl:value-of select="position()"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="RaceDt"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="TrackCd"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="TrackCondition"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="Furlong"/>
															</td>
															<td style="width: 3%;">
																<xsl:value-of select="FirstCall"/>
															</td>
															<td style="width: 3%;">
																<xsl:value-of select="SecondCall"/>
															</td>
															<td style="width: 3%;">
																<xsl:value-of select="StretchCall"/>
															</td>
															<td style="width: 3%;">
																<xsl:value-of select="FinalCall"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="RaceClassification"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="Purse"/>
															</td>
															<td style="width: 2%;">
																<xsl:value-of select="BrisSpeedRating"/>
															</td>
															<td style="width: 2%;">
																<xsl:value-of select="PreviousPostPosition"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="FirstCallPosition"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="SecondCallPosition"/>
															</td >
															<td style="width: 4%;">
																<xsl:value-of select="StretchCallPosition"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="FinishPosition"/>
															</td>
															<td style="width: 5%;">
																<xsl:value-of select="WinnerName"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="FirstPlace"/>
															</td>
															<td style="width: 5%;">
																<xsl:value-of select="SecondPlaceFinisherName"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="SecondPlace"/>
															</td>
															<td style="width: 5%;">
																<xsl:value-of select="ThirdPlaceFinisherName"/>
															</td>
															<td style="width: 4%;">
																<xsl:value-of select="ThirdPlace"/>
															</td>
															<td style="width: 7%;">
																<xsl:value-of select="TripComment"/>
															</td>
															<td style="width: 10%;">
																<xsl:value-of select="ExtendedStartComment"/>
															</td>
														</tr>
													</xsl:for-each>
												</tbody>
											</table>
										</div>
									</div>
									<div class="col-12 w-100">
										<h5 class="fw-bold">Workouts</h5>
										<div class="container-fluid">
											<div class="row">
												<xsl:for-each select="Workouts/Workout">
													<div class="col-3">
														<div class="container">
															<div class="row" style="font-size: 12px;">
																<div class="col-1 fw-bold">
																	<xsl:value-of select="position()"/>
																</div>
																<div class="col-2">
																	<xsl:value-of select="DisplayWorkoutDate"/>
																</div>
																<div class="col-2">
																	<xsl:value-of select="WorkoutTrack"/>
																</div>
																<div class="col-2">
																	<xsl:value-of select="Furlong"/>
																</div>
																<div class="col-2">
																	<xsl:value-of select="WorkoutTime"/>
																</div>
																<div class="col-1">
																	<xsl:value-of select="WorkoutTrackCondition"/>
																</div>
																<div class="col-1">
																	<xsl:value-of select="WorkoutDescription"/>
																</div>
																<div class="col-1">
																	<xsl:value-of select="WorkoutRanking"/>
																</div>
															</div>
														</div>
													</div>
												</xsl:for-each>
											</div>
										</div>
									</div>
								</div>
							</xsl:for-each>
						</div>
					</section>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
