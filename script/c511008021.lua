--Delayed Summon
--Scripted by Snrk
function c511008021.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511008021.condition)
	e1:SetTarget(c511008021.target)
	e1:SetOperation(c511008021.activate)
	c:RegisterEffect(e1)
	if not c511008021.global_check then
		c511008021.global_check=true
		c511008021[0]=0
		c511008021[1]=0
		sv=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON)
		ge1:SetOperation(c511008021.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON)
		Duel.RegisterEffect(ge2,0)
		local ge3=ge1:Clone()
		ge3:SetCode(EVENT_FLIP_SUMMON)
		Duel.RegisterEffect(ge3,0)
		local ge4=Effect.CreateEffect(c)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge4:SetOperation(c511008021.clear)
		Duel.RegisterEffect(ge4,0)
	end
end
function c511008021.checkop(e,tp,eg,ep,ev,re,r,rp)
	c511008021[ep]=1
end
function c511008021.clear(e,tp,eg,ep,ev,re,r,rp)
	self=e:GetHandler():GetOwner()
	if c511008021[self]==1 then sv=1 else sv=0 end
	c511008021[0]=0 c511008021[1]=0
end
function c511008021.hfilter(c)
	return c:IsSummonable(true,nil,1) or c:IsMSetable(true,nil,1)
end
function c511008021.condition(e,tp,eg,ep,ev,re,r,rp)
	return sv==0 and Duel.IsExistingMatchingCard(c511008021.hfilter,tp,LOCATION_HAND,0,1,nil) and Duel.GetAttacker():GetControler()==1-tp
end
function c511008021.target(e,tp,eg,ep,ev,re,r,rp,chk)
	Debug.Message(""..Duel.GetAttacker():GetControler().." = "..1-tp.."")
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c511008021.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c511008021.hfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local s1=tc:IsSummonable(true,nil,1)
		local s2=tc:IsMSetable(true,nil,1)
		if (s1 and s2 and Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)==POS_FACEUP_ATTACK) or not s2 then
			Duel.Summon(tp,tc,true,nil,1)
		else
			Duel.MSet(tp,tc,true,nil,1)
		end
	end
end