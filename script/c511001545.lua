--Beastborg Panther Predator
function c511001545.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c511001545.fusfilter1,c511001545.fusfilter2,true)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6602300,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511001545.damtg)
	e1:SetOperation(c511001545.damop)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35952884,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c511001545.sumcon)
	e2:SetTarget(c511001545.sumtg)
	e2:SetOperation(c511001545.sumop)
	c:RegisterEffect(e2)
end
function c511001545.fusfilter1(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_BEASTWARRIOR)
end
function c511001545.fusfilter2(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_MACHINE)
end
function c511001545.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetHandler():GetAttack()/2)
end
function c511001545.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,e:GetHandler():GetAttack()/2,REASON_EFFECT)
end
function c511001545.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c511001545.mgfilter(c,e,tp,fusc)
	return not c:IsControler(tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x40008)~=0x40008 or c:GetReasonCard()~=fusc
		or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001545.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=e:GetHandler():GetMaterial()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if chk==0 then return mg:GetCount()>0 and ft>=mg:GetCount() 
		and not mg:IsExists(c511001545.mgfilter,1,nil,e,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,mg,mg:GetCount(),tp,0)
end
function c511001545.sumop(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetMaterial()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if mg:GetCount()>ft 
		or mg:IsExists(c511001545.mgfilter,1,nil,e,tp,e:GetHandler()) then return end
	Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
end
